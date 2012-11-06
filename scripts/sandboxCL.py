#!/usr/bin/env python

# sandbox multifractal implementation
# Rodrigo Baravalle - October 2012

#import random
from random import randrange,randint
from math import log
from scipy import ndimage
#from pylab import plot, title, show , legend
#import matplotlib
#from matplotlib import pyplot as plt
import time
import Image
import numpy as np
import sys
import os
import pyopencl as cl
import pyopencl.array
import pyopencl.reduction

ctx = cl.create_some_context()
queue = cl.CommandQueue(ctx)
#print ctx, queue
mf = cl.mem_flags

total = 40*40      # number of pixels for averaging
P = 40             # window
cant = 10+1           # number of fractal dimensions (-1 x2)

# returns the sum of (summed area) image pixels in the box between
# (x1,y1) and (x2,y2)
def mww(x1,y1,x2,y2,intImg):
    sum = intImg[x2][y2]
    if (x1>= 1 and y1 >= 1):
        sum = sum + intImg[x1-1][y1-1]
    if (x1 >= 1):
        sum = sum - intImg[x1-1][y2];
    if (y1 >= 1):
        sum = sum - intImg[x2][y1-1]
    return sum/((x2-x1+1)*(y2-y1+1));

def sat(img,Nx,Ny,which):
    # summed area table, useful for speed up the computation by adding image pixels 
    intImg = [ [ 0 for i in range(Nx) ] for j in range(Ny) ]
    if(which == 'img'):
        intImg[0][0] = img.getpixel((0,0))
        
        arrNx = range(1,Nx)
        arrNy = range(1,Ny)
        for h in arrNx:
            intImg[h][0] = intImg[h-1][0] + img.getpixel((h,0))
        
        for w in arrNy:
            intImg[0][w] = intImg[0][w-1] + img.getpixel((0,w))
        
        for f in arrNx:
            for g in arrNy:
               intImg[f][g] = img.getpixel((f,g))+intImg[f-1][g]+intImg[f][g-1]-intImg[f-1][g-1]
    else:
        intImg[0][0] = img[0][0]
        
        arrNx = range(1,Nx)
        arrNy = range(1,Ny)
        for h in arrNx:
            intImg[h][0] = intImg[h-1][0] + img[h][0]
        
        for w in arrNy:
            intImg[0][w] = intImg[0][w-1] + img[0][w]
        
        for f in arrNx:
            for g in arrNy:
               intImg[f][g] = img[f][g]+intImg[f-1][g]+intImg[f][g-1]-intImg[f-1][g-1]

    return intImg

def white(img,Nx,Ny,vent,bias):
           
    intImg = sat(img,Nx,Ny,'img')
    a = np.array(intImg).astype(np.int32)
    im = np.zeros((Nx,Ny)).astype(np.int32)
    intImg_buf = cl.Buffer(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR, hostbuf=a)
    b = np.array(img).astype(np.int32)
    img_buf = cl.Buffer(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR, hostbuf=b)

    # where to store results
    dest_buf = cl.Buffer(ctx, mf.WRITE_ONLY, a.nbytes)
	
    prg = cl.Program(ctx, """
    float mww(int x1, int y1, int x2, int y2, __global int* intImg, const int Ny) {
        float sum = intImg[x2+y2*Ny];
        if (x1>= 1 && y1 >= 1) 
            sum += intImg[x1-1 + (y1-1)*Ny];
        if (x1 >= 1)
            sum -= intImg[x1-1 + y2*Ny];
        if (y1 >= 1)
            sum -= intImg[x2 + (y1-1)*Ny];
        return sum *= 1.0f/((x2-x1+1)*(y2-y1+1));
    }
    __kernel void white(__global int *intImg, __global int *img, __global int *dest, const int Nx, const int Ny, const int vent, const float bias) {
         int gidx = get_global_id(0);
         int gidy = get_global_id(1);
         int i = gidy;
         int j = gidx;
         if(mww(max(0,i-vent),max(0,j-vent),min(Nx-1,i+vent),min(Ny-1,j+vent),intImg,Ny) 
                    >= (float)img[j + i*Ny]*bias )
            dest[j+i*Ny] = img[j+i*Ny];
    }
    """).build()

    prg.white(queue, a.shape, intImg_buf, img_buf, dest_buf, np.int32(Nx), np.int32(Ny), np.int32(vent), np.float32(bias))
    cl.enqueue_read_buffer(queue, dest_buf, im).wait()

    # do an opening operation to remove small elements
    return ndimage.binary_opening(im, structure=np.ones((2,2))).astype(np.int32)


def count(x1,y1,x2,y2,intImg):
    sum = intImg[x2][y2]
    if (x1>= 1 and y1 >= 1):
        sum = sum + intImg[x1-1][y1-1]
    if (x1 >= 1):
        sum = sum - intImg[x1-1][y2];
    if (y1 >= 1):
        sum = sum - intImg[x2][y1-1]
    return sum
            

# v: window size
def spec(filename,v,bias):
    #import psyco # magical speed up
    #psyco.full()
    t = time.clock()
    tP = (P)   # tP : two raised to P
    x = tP+1
    y = tP+1
    cantSelected = 0

    a = Image.open(filename)
    Nx, Ny = a.size
    L = Nx*Ny

    points = []     # number of elements in the structure
    gray = a.convert('L') # rgb 2 gray

    gray = white(gray,Nx,Ny,v,bias) # local thresholding algorithm
    #plt.imshow(gray, cmap=matplotlib.cm.gray)
    #plt.show()
    #return
    intImg = sat(gray,Nx,Ny,'array')

    m0 = intImg[Nx-1][Ny-1]#/float(L)

    while(gray[x][y] == 0):
        x = randint(tP,Nx-tP-1)
        y = randint(tP,Ny-tP-1)

    # list with selected points (the points should be in the "structure")
    # points shouldn't be close to the borders, in order for the windows to have the same size
    while cantSelected < total:
        while(([x,y] in points) or count(x-1,y-1,x+1,y+1,intImg) == 0):
            x = randint(tP,Nx-tP-1)
            y = randint(tP,Ny-tP-1)
        # new point, add to list
        points.append([x,y])
        cantSelected = cantSelected+1

    c = np.zeros((P,total), dtype=np.float32 ) # total+1 rows x P columns
    for i in range(total): # for each point randomly selected
        x = points[i][0]
        y = points[i][1]
        for h in range(1,P+1):
            # how many points in the box. M(R) in the literature
            c[h-1][i] = count(x-(h),y-(h),x+(h),y+(h),intImg)

    down = range(1,P+1)
    # Generalized Multifractal Dimentions 
    s = [0 for i in range(2*cant-2)]
    l = range(-cant+1,0)+  range(1,cant)
    j = 0
    for i in l:
        s[j] = Dq(c,i,L,m0,down)

        j = j+1

    #plot(s)
    #show()

    t =  time.clock()-t
    print "Time: ", t
    #print "Dims: ", s
    return s

# parallel reduction of the sum in c[h]
krnl = pyopencl.reduction.ReductionKernel(ctx, np.float32, neutral="0",
        reduce_expr="a+b", map_expr="pow(x[i],q)/aux1",
        arguments="__global float *x, float q, const int aux1")

def Dq(c,q,L,m0,down):

    #aux = 1
    # sum in each radius, all the points
    if q>0: # math representation issue
        aux1 = float(total)
        aux2 = 0
    else:
        aux1 = 1
        aux2 = log(float(total))

    # next power of two, bigger than total
    pot = 1;
    while(pot <= total):
        pot = pot*2

    # padded_c has the same shape as c, transposed and padded
    trans_c = np.array(zip(*c)).astype(np.float32)  # transpose c
    #padded_c = np.hstack((trans_c,np.zeros((P,pot-total)).astype(np.float32)))
    #print len(padded_c[4]), pot, total
    d = np.zeros(P).astype(np.float32)

    for h in range(P):        
 #      c[h-1][0] = c[h-1][0] + ((c[h-1][i+1]**q)/aux1) # mean of "total" points
        a = np.array(c[h]).astype(np.float32)
        in_buf = cl.Buffer(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR, hostbuf=a)
        dest_buf = cl.Buffer(ctx, mf.WRITE_ONLY, a.nbytes)
        # where to store results      
        a = pyopencl.array.to_device(queue,a)
        d[h] = krnl(a, np.float32(q), np.int32(aux1)).get()  

    #print "d: ", d
    up = map(lambda i: log(i)-aux2-q*log(m0), d)
    #print up
    up2 = map(lambda i: up[i]/(q*down[i]), range(len(up)))
    sizes = range(1,P+1)

    (ar,br)=np.polyfit(sizes,up2,1)
    return ar
    
print spec('../imagenes/scanner/baguette/baguette9.tif',40,1.15)

