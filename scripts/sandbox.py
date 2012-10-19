#!/usr/bin/env python

# sandbox multifractal implementation
# Rodrigo Baravalle - October 2012


import random
from random import randrange,randint
from math import log
from scipy import linspace, polyval, polyfit, sqrt, stats, randn, ndimage
from pylab import plot, title, show , legend
import matplotlib
from matplotlib import pyplot as plt
import time
import Image
import numpy as np
import sys
import os

total = 30*50      # number of pixels for averaging
P = 18              # window
cant = 6           # number of fractal dimensions (-1 x2)

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
           
    im = np.zeros((Nx,Ny))
    
    intImg = sat(img,Nx,Ny,'img')
        
    arrNx = range(Nx)
    arrNy = range(Ny)

    for i in arrNx:
        for j in arrNy:
            if(mww(max(0,i-vent),max(0,j-vent),min(Nx-1,i+vent),min(Ny-1,j+vent),intImg) >= img.getpixel((i,j))*bias ): 
                im[j,i] = img.getpixel((i,j))

    # do an opening operation to remove small elements
    return ndimage.binary_opening(im, structure=np.ones((2,2))).astype(np.int)


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
def spec(filename,v,b):
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

    gray = white(gray,Nx,Ny,v,b) # local thresholding algorithm
    plt.imshow(gray, cmap=matplotlib.cm.gray)
    plt.show()

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


    c = [ [ 0 for i in range(P) ] for j in range(total+1) ] # total+1 rows x P columns
    for i in range(total): # for each point randomly selected
        x = points[i][0]
        y = points[i][1]
        for h in range(1,P+1):
            # how many points in the box. M(R) in the literature
            c[i+1][h-1] = count(x-(h),y-(h),x+(h),y+(h),intImg)

    down = range(1,P+1)
    # Generalized Multifractal Dimentions 
    s = [0 for i in range(2*cant-2)]
    l = range(-cant+1,0)+  range(1,cant)
    print l
    j = 0
    for i in l:
        s[j] = Dq(c,i,L,m0,down)
        j = j+1

    #plot(s)
    #show()

    t =  time.clock()-t
    print "Time: ", t
    print "Dims: ", s
    return s

def Dq(c,q,L,m0,down):

    #aux = 1
    # sum in each radius, all the points
    for h in range(1,P+1):        
        for i in range(total):
            c[0][h-1] = c[0][h-1] + ((c[i+1][h-1]**q)/(float(total))) # mean of "total" points

    #print "C", c[0]
    up = map(lambda i: log(i)-q*log(m0), c[0])
    up = map(lambda i: up[i]/(q*down[i]), range(len(up)))
    sizes = range(1,P+1)

    (ar,br)=polyfit(sizes,up,1)
    return ar
    


