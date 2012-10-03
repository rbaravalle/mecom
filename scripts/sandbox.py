
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
a = Image.open('/home/rodrigo/mecom2012/mecom/imagenes/scanner/baguette/baguette1.tif')

gray = a.convert('L') # rgb 2 gray
gray = gray.point(lambda i: 255*(i<100)) # threshold (white's algorithm IMPLEMENT!)

gray.show()

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


