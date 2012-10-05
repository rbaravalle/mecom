
#!/usr/bin/env python

# sandbox multifractal implementation
# Rodrigo Baravalle - October 2012

import random
from random import randrange
import sys
from time import time
from datetime import datetime
import os
from os import system
from os import unlink
from subprocess import *
from math import log
from scipy import linspace, polyval, polyfit, sqrt, stats, randn
from pylab import plot, title, show , legend

import Image
import numpy
a = Image.open('/home/rodrigo/mecom2012/mecom/imagenes/scanner/baguette/baguette1.tif')

gray = a.convert('L') # rgb 2 gray
gray = gray.point(lambda i: 255*(i<100)) # threshold (white's algorithm IMPLEMENT!)
gray.show()
total = 1000      # number of pixels for averaging
points = []     # number of elements in the structure
Nx, Ny = a.size

def count(a):   # counts the number of white pixels in the region a
    xsize, ysize = a.size
    sum = 0
    for i in range(xsize):
        for j in range(ysize):
            sum = sum + (a.getpixel((i,j)) > 0)

    return sum
            

m0 = count(a)
L = Nx
P = 8

def main():
    x = 0
    y = 0
    cantSelected = 0

    while(gray.getpixel((x,y)) == 0):
        x = int(random.random()*Nx)
        y = int(random.random()*Ny)

    # list with selected points (the points should be in the "structure")
    while cantSelected < total:
        while(([x,y] in points) or count(gray.crop((max(0,x-1),max(0,y-1),min(Nx-1,x+1),min(Ny-1,y+1)))) == 0):
            x = int(random.random()*Nx)
            y = int(random.random()*Ny)
        # new point, add to list
        points.append([x,y])
        cantSelected = cantSelected+1
    #print "Occupied: ", occupied

    l = range(P)
    l = map(lambda i: i+1,l)
    c = [ [ 0 for i in range(P) ] for j in range(total+1) ]
    tot = range(total)
    for i in tot: # for each point randomly selected
        x = points[i][0]
        y = points[i][1]
        for h in l:
            # how many points in the box. M(R) in the literature
            c[i+1][h-1] = count(gray.crop((max(0,x-h),max(0,y-h),min(Nx-1,x+h),min(Ny-1,y+h))))/float(m0)
            if(c[i+1][h-1] == 0):
                print "error ", i, h
        
    # mean of all points       
    print "Dimentions: ", Dq(c,-4), Dq(c,-2), Dq(c,2), Dq(c,4)

def Dq(c,q):

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
    
    
main()


