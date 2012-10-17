import sandbox
import csv
import sys
import os
from subprocess import *

def main():

    a = [[0] for i in range(100)]
    csvfile = '../exps/sandboxS.csv'
    reader = csv.reader(file(csvfile))
    c = 0
    for row in reader:
        a[c] = row
        c = c +1
    
    csvfile = '../exps/fractal2s.csv'    
    reader = csv.reader(file(csvfile))
    c = 0
    for row in reader:
        a[c] = a[c] + row
        c = c +1

    with open('../exps/sandfractalS.csv', 'wb') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(a[0:])

    a = [[0] for i in range(100)]
    csvfile = '../exps/sandboxC.csv'
    reader = csv.reader(file(csvfile))
    c = 0
    for row in reader:
        a[c] = row
        c = c +1
    
    csvfile = '../exps/fractal2c.csv'    
    reader = csv.reader(file(csvfile))
    c = 0
    for row in reader:
        a[c] = a[c] + row
        c = c +1

    with open('../exps/sandfractalC.csv', 'wb') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(a[0:])

    prog = './a.out' # convert.c
    csvS = '../exps/sandfractalS.csv'
    csvC = '../exps/sandfractalC.csv'
    txtS = '../exps/sandfractalS.txt'
    txtC = '../exps/sandfractalC.txt'
    cmd = '{0} "{1}" > "{2}"'.format(prog, csvS, txtS)
    Popen(cmd, shell = True, stdout = PIPE).communicate()	
    cmd = '{0} "{1}" > "{2}"'.format(prog, csvC, txtC)
    Popen(cmd, shell = True, stdout = PIPE).communicate()
    

main()
