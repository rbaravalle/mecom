#!/usr/bin/env python

# singularity multifractal implementation
# Rodrigo Baravalle - November 2012

#import random
from random import randrange,randint
from math import log
from scipy import ndimage
from pylab import plot, title, show , legend
import matplotlib
from matplotlib import pyplot as plt
import time
import Image
import numpy as np
import sys
import os

cant = 20+1           # number of fractal dimensions (-1 x2)

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
def spec(filename,v,b,cuantas):
    t = time.clock()
    cantSelected = 0

    a = Image.open(filename)
    Nx, Ny = a.size
    L = Nx*Ny

    points = []     # number of elements in the structure
    gray = a.convert('L') # rgb 2 gray

    #plt.imshow(gray, cmap=matplotlib.cm.gray)
    #plt.show()

    alphaIm = np.zeros((Nx,Ny), dtype=np.double ) # Nx rows x Ny columns
    #measure = np.zeros(4, dtype=np.double ) # Ny rows x 4 columns

    l = 4 # (maximum window size-1) / 2
    # from 1 to l
    temp = np.log((1.0,3.0,5.0,7.0));
    measure = np.zeros(4);

    for i in range(0,Nx-1):
        for j in range(0,Ny-1):
            measure[0] = min(gray.crop((max(i-1,0),max(j-1,0),min(i+1,Nx-1),min(j+1,Ny-1))).getdata()) + 1
            measure[1] = min(gray.crop((max(i-2,0),max(j-2,0),min(i+2,Nx-1),min(j+2,Ny-1))).getdata()) + 1
            measure[2] = min(gray.crop((max(i-3,0),max(j-3,0),min(i+3,Nx-1),min(j+3,Ny-1))).getdata()) + 1
            measure[3] = min(gray.crop((max(i-4,0),max(j-4,0),min(i+4,Nx-1),min(j+4,Ny-1))).getdata()) + 1
            #alphaIm[j,i] = np.polyfit(temp,np.log(measure),1)[0]

    #maxim = np.max(alphaIm)
    #minim = np.min(alphaIm)

    # Alpha image
    #plt.imshow(alphaIm, cmap=matplotlib.cm.gray)
    #plt.show()

    #paso = (maxim-minim)/cuantas;
    #clases = np.arange(minim,maxim,paso);
    #print "Alpha im", alphaIm
    #print "Paso: ", paso
    #print "Clases: ", clases

    # Window
    cant = int(np.floor(np.log(Nx)));

    for c in range(cuantas):
        N = np.zeros(cant+1)
        for k in range(cant+1):
            sizeBlocks = 2*k+1
            numBlocks_x = int(np.ceil(Nx/sizeBlocks))
            numBlocks_y = int(np.ceil(Ny/sizeBlocks))
            print sizeBlocks, numBlocks_x, numBlocks_y

            flag = np.zeros((numBlocks_x,numBlocks_y))

            for i in range(1,numBlocks_x):
                for j in range(1,numBlocks_y):
                    block = alphaIm[(i-1)*sizeBlocks + 1:i*sizeBlocks, (j-1)*sizeBlocks + 1:j*sizeBlocks]

    t =  time.clock()-t
    print "Time: ", t

    

spec('../imagenes/scanner/baguette/baguette1.tif',1,1,20)
