
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
a = numpy.asarray( Image.open('/home/rodrigo/mecom2012/mecom/imagenes/scanner/baguette/baguette1.tif') )

r = a[:, :, 0] # slices are not full copies, they cost little memory
g = a[:, :, 1]
b = a[:, :, 2]

r = r.astype(float)
g = g.astype(float)
b = b.astype(float)

r = r/255;
g = g/255;
b = b/255;

gray = 0.2989 * r + 0.5870 * g + 0.1140 * b  # from MATLAB rgb2gray

gray = gray  < 0.4 # white's algorithm IMPLEMENT!

gray = (gray*255).astype(numpy.uint8)

b = Image.fromstring('L', (gray.shape[1], gray.shape[0]), gray.tostring())
b.show()

#gray = gray  > 0.5 # white's algorithm IMPLEMENT!

total = 75      # number of pixels for averaging
occupied = []   # number of elements in the structure


def main():
    x = 0
    y = 0
    cantSelected = 0
    # list with selected points
    while cantSelected < total:
        while([x,y] in occupied or gray[x][y] == False):
            x = int(random.random()*380)
            y = int(random.random()*380)
        # new point, add to list
        occupied.append([x,y])
        cantSelected = cantSelected+1
    #print "Occupied: ", occupied

    P = 4 # parameter
    l = range(P)
    for r in l:
        print "P: ", r


main()


