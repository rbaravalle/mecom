#!/usr/bin/env python

# sandbox multifractal implementation
# Rodrigo Baravalle - October 2012

#import psyco # magical speed up
#psyco.full()

import random
from random import randrange
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

total = 75*75      # number of pixels for averaging
P = 8

# returns the sum of (summed area) image pixels in the box between
# (x1,y1) and (x2,y2)
def mww(x1,y1,x2,y2,intImg):
    sum = intImg[x2][y2]-intImg[x1][y2]-intImg[x2][y1]+intImg[x1][y1]
    return sum/((x2-x1+1)*(y2-y1+1));

def white(img,Nx,Ny,vent):

    # parameters
    bias = 1;
           
    im = np.zeros((Nx,Ny))
    
    intImg = [ [ 0 for i in range(Nx) ] for j in range(Ny) ]
    
    # summed area table, useful for speed up the computation by adding image pixels 
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
    
    arrNx = range(Nx)
    arrNy = range(Ny)

    im2 = ndimage.gaussian_filter(img, sigma=256/(4.*16))
    im2 = (im2 < im2.mean()/2)

    for i in arrNx:
        for j in arrNy:
            if(mww(max(0,i-vent),max(0,j-vent),min(Nx-1,i+vent),min(Ny-1,j+vent),intImg) >= img.getpixel((i,j))*bias or (im2[j][i] > 0)):
                im[j,i] = 1

    # do an opening operation to remove small elements
    return ndimage.binary_opening(im, structure=np.ones((2,2))).astype(np.int),intImg


def count(x1,y1,x2,y2,intImg):
    sum = intImg[x2][y2]-intImg[x1][y2]-intImg[x2][y1]+intImg[x1][y1]
    return sum;
            

# v: window size
def spec(filename,v):
    t = time.clock()
    x = 0
    y = 0
    cantSelected = 0

    a = Image.open(filename)
    Nx, Ny = a.size
    L = Nx*Ny

    points = []     # number of elements in the structure
    gray = a.convert('L') # rgb 2 gray

    gray, intImg = white(gray,Nx,Ny,v) # local (+global) thresholding algorithm
    #plt.imshow(gray, cmap=matplotlib.cm.gray)
    #plt.show()

    m0 = count(0,0,Nx-1,Ny-1,intImg)

    while(gray[x][y] == 0):
        x = int(random.random()*Nx)
        y = int(random.random()*Ny)

    # list with selected points (the points should be in the "structure")
    while cantSelected < total:
        while(([x,y] in points) or count(max(0,x-1),max(0,y-1),min(Nx-1,x+1),min(Ny-1,y+1),intImg) == 0):
            x = int(random.random()*Nx)
            y = int(random.random()*Ny)
        # new point, add to list
        points.append([x,y])
        cantSelected = cantSelected+1

    l = range(P)
    l = map(lambda i: i+1,l)
    c = [ [ 0 for i in range(P) ] for j in range(total+1) ]
    tot = range(total)
    for i in tot: # for each point randomly selected
        x = points[i][0]
        y = points[i][1]
        for h in l:
            # how many points in the box. M(R) in the literature
            c[i+1][h-1] = count(max(0,x-h),max(0,y-h),min(Nx-1,x+h),min(Ny-1,y+h),intImg)/float(m0)
            #if(c[i+1][h-1] == 0):
             #   print "error ", i, h
        
    # Generalized Multifractal Dimentions 
    s = map(lambda i: Dq(c,i,L), range(-8,-1) + range(1,8))

    t =  time.clock()-t
    print "Time: ", t
    print "Dims: ", s
    return s

def Dq(c,q,L):

    tot = range(total)
    l = range(P)
    l = map(lambda i: i+1,l)
    for i in tot:
        for h in l:        
            c[0][h-1] = c[0][h-1] + c[i+1][h-1]**q

    mean = map(lambda i: float(i)/total,c[0])

    up = mean
    down = map(lambda i: float(i)/L,map(lambda i: i+1,range(P)))

    res = range(2*P)
    r = map(lambda i: i-P,res)

    t = map(lambda i: log(i), up)
    u = map(lambda i: log(i), down)
    res = [a / (b*q) for a, b in zip(t, u)]

    (ar,br)=polyfit(range(P),res,1)
    return ar
    


