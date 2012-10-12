#!/usr/bin/env python

# sandbox multifractal implementation
# Rodrigo Baravalle - October 2012

#import psyco # magical speed up
#psyco.full()

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

total = 20*20      # number of pixels for averaging
P = 5              # window
cant = 4

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

    #im2 = ndimage.gaussian_filter(img, sigma=256/(4.*16))
    #im2 = (im2 < im2.mean()/2)

    for i in arrNx:
        for j in arrNy:
            if(mww(max(0,i-vent),max(0,j-vent),min(Nx-1,i+vent),min(Ny-1,j+vent),intImg) >= img.getpixel((i,j))*bias ): 
            #or (im2[j][i] > 0)):
                im[j,i] = 1

    # do an opening operation to remove small elements
    return ndimage.binary_opening(im, structure=np.ones((2,2))).astype(np.int)


def count(x1,y1,x2,y2,intImg):
    #print x1, y1, x2, y2
    sum = intImg[x2][y2]
    if (x1>= 1 and y1 >= 1):
        sum = sum + intImg[x1-1][y1-1]
    if (x1 >= 1):
        sum = sum - intImg[x1-1][y2];
    if (y1 >= 1):
        sum = sum - intImg[x2][y1-1]
    return sum;
            

# v: window size
def spec(filename,v,b):
    t = time.clock()
    tP = (2**P)   # tP : two raised to P
    x = tP+1
    y = tP+1
    cantSelected = 0

    a = Image.open(filename)
    Nx, Ny = a.size
    L = Nx*Ny

    points = []     # number of elements in the structure
    gray = a.convert('L') # rgb 2 gray

    gray = white(gray,Nx,Ny,v,b) # local thresholding algorithm
    #plt.imshow(gray, cmap=matplotlib.cm.gray)
    #plt.show()

    intImg = sat(gray,Nx,Ny,'array')

    m0 = intImg[Nx-1][Ny-1]

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


    c = [ [ 0 for i in range(P) ] for j in range(total+1) ]
    for i in range(total): # for each point randomly selected
        x = points[i][0]
        y = points[i][1]
        for h in range(1,P+1):
            # how many points in the box. M(R) in the literature
            c[i+1][h-1] = count(x-(2**(h-1)),y-(2**(h-1)),x+(2**(h-1)),y+(2**(h-1)),intImg)
            if(c[i+1][h-1] == 0):
                print "error ", i, h
        
    down = map(lambda i: log(L/(float(2*(2**i)+1)**2)),range(1,P+1))
    # Generalized Multifractal Dimentions 
    s = map(lambda i: Dq(c,i,L,m0,down), range(-cant,-1) + range(1,cant))

    t =  time.clock()-t
    print "Time: ", t
    print "Dims: ", s
    return s

def Dq(c,q,L,m0,down):

    #l   = range(1,P+1)#map(lambda i: i+1,range(P))
    for i in range(total):
        for h in range(1,P+1):        
            c[0][h-1] = c[0][h-1] + (m0/c[i+1][h-1])**q # [M0 / M(R)] ** q-1

    print "C[0]: ", c[0], q
    mean = map(lambda i: (float(i)/total)/q,c[0])   # mean of ([M0 / M(R)] ** q-1 ) / q-1

    print "Mean: ", mean
    up = map(lambda i: log(i+0.01), mean)
    print "up: ", up
    print "down: ", down

    #res = [a / (b*q) for a, b in zip(t, u)]

    (ar,br)=polyfit(down,up,1)
    return ar
    


