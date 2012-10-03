
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

import Image
import numpy
a = Image.open('/home/rodrigo/mecom2012/mecom/imagenes/scanner/baguette/baguette1.tif')

gray = a.convert('L') # rgb 2 gray
gray = gray.point(lambda i: 255*(i<100)) # threshold (white's algorithm IMPLEMENT!)

total = 1000      # number of pixels for averaging
points = []     # number of elements in the structure
Nx = 380
Ny = 380

def count(a):   # counts the number of white pixels in the region a
    xsize, ysize = a.size
    sum = 0
    for i in range(xsize):
        for j in range(ysize):
            sum = sum + (a.getpixel((i,j)) > 0)

    return sum
            

def main():
    x = 0
    y = 0
    cantSelected = 0

    while(gray.getpixel((x,y)) == 0):
        x = int(random.random()*Nx)
        y = int(random.random()*Ny)

    # list with selected points (the points should be in the "structure")
    while cantSelected < total:
        while(([x,y] in points) or (gray.getpixel((x,y)) == 0)):
            x = int(random.random()*Nx)
            y = int(random.random()*Ny)
        # new point, add to list
        points.append([x,y])
        cantSelected = cantSelected+1
    #print "Occupied: ", occupied

    P = 4 # parameter
    l = range(P)
    print l
    l = map(lambda i: i+1,l)
    print l
    c = [ [ 0 for i in range(P) ] for j in range(total+1) ]
    tot = range(total)
    for i in tot: # for each point randomly selected
        x = points[i][0]
        y = points[i][1]
        for h in l:
            # how many points in the box. M(R) in the literature
            c[i+1][h-1] = count(gray.crop((max(0,x-h),max(0,y-h),min(Nx-1,x+h),min(Ny-1,y+h))))
            c[0][h-1] = c[0][h-1] + c[i+1][h-1]
        
        
    mean = range(P)
    # mean of all points       
    mean = map(lambda i: float(i)/total,c[0])
    print mean

    

    
main()


