import sandbox
import csv
import os

def main():
    cant = 21
    DFs  = 8
    baguette = [['Df' for j in range(2*DFs)] for i in range(cant)]
    lactal   = [['Df' for j in range(2*DFs)] for i in range(cant)]
    salvado  = [['Df' for j in range(2*DFs)] for i in range(cant)]
    sandwich = [['Df' for j in range(2*DFs)] for i in range(cant)]

    baguetteC = [['Df' for j in range(2*DFs)] for i in range(cant)]
    lactalC   = [['Df' for j in range(2*DFs)] for i in range(cant)]
    salvadoC  = [['Df' for j in range(2*DFs)] for i in range(cant)]
    sandwichC = [['Df' for j in range(2*DFs)] for i in range(cant)]

    path = '../exps/100sample/res/'
    dirList=os.listdir(path)
    
    nonbread = [['Df' for j in range(2*DFs)] for i in range(len(dirList))]


    for i in range(len(dirList)):
        v = 7
        filename = path+dirList[i]
        print filename
        nonbread[i] = sandbox.spec(filename,v)

    for i in range(1,cant):
        v = 7
        filename = '../imagenes/scanner/baguette/baguette{}.tif'.format(i)
        print filename
        baguette[i] = sandbox.spec(filename,v)
        filename = '../imagenes/scanner/lactal/lactal{}.tif'.format(i)
        print filename
        lactal[i] = sandbox.spec(filename,v)
        filename = '../imagenes/scanner/salvado/salvado{}.tif'.format(i)
        print filename
        salvado[i] = sandbox.spec(filename,v)
        filename = '../imagenes/scanner/sandwich/sandwich{}.tif'.format(i)
        print filename
        sandwich[i] = sandbox.spec(filename,v)

        v = 17
        filename = '../imagenes/camera/baguette/b{}.tif'.format(i)
        print filename
        baguetteC[i] = sandbox.spec(filename,v)
        filename = '../imagenes/camera/lactal/l{}.tif'.format(i)
        print filename
        lactalC[i] = sandbox.spec(filename,v)
        filename = '../imagenes/camera/salvado/s{}.tif'.format(i)
        print filename
        salvadoC[i] = sandbox.spec(filename,v)
        filename = '../imagenes/camera/sandwich/s{}.tif'.format(i)
        print filename
        sandwichC[i] = sandbox.spec(filename,v)


    with open('baguette.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(baguette)
    with open('lactal.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(lactal)
    with open('salvado.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(salvado)
    with open('sandwich.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(sandwich)

    with open('sandboxS.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(baguette[1:]+lactal[1:]+salvado[1:]+sandwich[1:]+nonbread[0:20])


    with open('baguetteC.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(baguetteC)
    with open('lactalC.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(lactalC)
    with open('salvadoC.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(salvadoC)
    with open('sandwichC.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(sandwichC)

    with open('sandboxC.csv', 'wb') as f:
        writer = csv.writer(f)
        writer.writerows(baguetteC[1:]+lactalC[1:]+salvadoC[1:]+sandwichC[1:]+nonbread[20:40])

main()
