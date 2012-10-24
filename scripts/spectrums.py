import sandbox
import csv
import sys
import os
from subprocess import *
import conf # confusion matrix
import numpy

def main():
    cant = 20+1
    dDFs  = 2*10
    cantClasses = 5
    baguette = [['Df' for j in range(dDFs)] for i in range(cant)]
    lactal   = [['Df' for j in range(dDFs)] for i in range(cant)]
    salvado  = [['Df' for j in range(dDFs)] for i in range(cant)]
    sandwich = [['Df' for j in range(dDFs)] for i in range(cant)]
    ursula   = [['Df' for j in range(dDFs)] for i in range(cant)]

    baguetteC = [['Df' for j in range(dDFs)] for i in range(cant)]
    lactalC   = [['Df' for j in range(dDFs)] for i in range(cant)]
    salvadoC  = [['Df' for j in range(dDFs)] for i in range(cant)]
    sandwichC = [['Df' for j in range(dDFs)] for i in range(cant)]
    ursulaC   = [['Df' for j in range(dDFs)] for i in range(cant)]

    path = '../exps/100sample/res/'
    dirList=os.listdir(path)
    print len(dirList)
    
    nonbread = [['Df' for j in range(dDFs)] for i in range(len(dirList))]

    nruns = 10
    votings = [[0 for j in range((cant-1)*cantClasses)] for i in range(nruns)]
    crossVs = [0 for j in range(nruns)]

    for h in range(nruns):
        print "Run number: ", h+1
        for i in range(41):
            v = 40
            b = 1.15
            filename = path+dirList[i]
            print filename
            nonbread[i] = sandbox.spec(filename,v,b)

        for i in range(1,cant):
            v = 40  # window
            b = 1.2 # bias
            filename = '../imagenes/scanner/baguette/baguette{}.tif'.format(i)
            print filename
            baguette[i] = sandbox.spec(filename,v,b)
            filename = '../imagenes/scanner/lactal/lactal{}.tif'.format(i)
            print filename
            lactal[i] = sandbox.spec(filename,v,b)
            filename = '../imagenes/scanner/salvado/salvado{}.tif'.format(i)
            print filename
            salvado[i] = sandbox.spec(filename,v,b)
            filename = '../imagenes/scanner/sandwich/sandwich{}.tif'.format(i)
            print filename
            sandwich[i] = sandbox.spec(filename,v,b)
            #filename = '../imagenes/scanner/gonzales/allied{}a.tif'.format(i)
            #print filename
            #ursula[i] = sandbox.spec(filename,v,b)

            v = 50
            b = 1.05
            filename = '../imagenes/camera/baguette/slicer/b{}.tif'.format(i)
            print filename
            baguetteC[i] = sandbox.spec(filename,v,b)
            filename = '../imagenes/camera/lactal/l{}.tif'.format(i)
            print filename
            lactalC[i] = sandbox.spec(filename,v,b)
            filename = '../imagenes/camera/salvado/s{}.tif'.format(i)
            print filename
            salvadoC[i] = sandbox.spec(filename,v,b)
            filename = '../imagenes/camera/sandwich/s{}.tif'.format(i)
            print filename
            sandwichC[i] = sandbox.spec(filename,v,b)
            #filename = '../imagenes/camera/gonzales/allied{}c.tif'.format(i)
            #print filename
            #ursulaC[i] = sandbox.spec(filename,v,b)

        with open('../exps/sandboxS.csv', 'wb') as f:
            writer = csv.writer(f)
            writer.writerows(baguette[1:]+lactal[1:]+salvado[1:]+sandwich[1:]+nonbread[0:20])

        with open('../exps/sandboxC.csv', 'wb') as f:
            writer = csv.writer(f)
            writer.writerows(baguetteC[1:]+lactalC[1:]+salvadoC[1:]+sandwichC[1:]+nonbread[20:40])

        prog = './a.out' # convert.c
        csvS = '../exps/sandboxS.csv'
        csvC = '../exps/sandboxC.csv'
        txtS = '../exps/sandboxS.txt'
        txtC = '../exps/sandboxC.txt'
        cmd = '{0} "{1}" > "{2}"'.format(prog, csvS, txtS)
        Popen(cmd, shell = True, stdout = PIPE).communicate()	
        cmd = '{0} "{1}" > "{2}"'.format(prog, csvC, txtC)
        Popen(cmd, shell = True, stdout = PIPE).communicate()

        # confusion matrix
        testL = conf.test() # test results and show confusion matrix
        votings[h] = testL
        cr =  conf.getCross()
        print "Actual Cross Validation: "
        crossVs[h] = cr

    finalRes = map(lambda i: most_common(i),zip(*votings))
    print 'FinalRes: '
    print finalRes
    print 'Votings: '
    print votings
    print "New Matrix Conf"
    a = [i for i in range(len(finalRes)-1)]
    a = map(lambda i: i/20+1, a)
    b = conf.conf_mat(finalRes,a)

    suma = 0
    c = 0
    for row in b:
        suma = suma + row[c]
        print row
        c = c+1

    finalRobustness = float(suma)/((cant-1)*cantClasses)
    finalCrossV = numpy.mean(crossVs);

    print "Different Cross Validations: ", crossVs
    print "Final Robustness: ", finalRobustness*100, "%"
    print "Final Cross Validation: ", finalCrossV


def most_common(lst):
    return max(set(lst), key=lst.count)


main()
