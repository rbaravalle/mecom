import sys
from subprocess import *

def conf_mat(test, classes):
        m = [ [0 for i in range(max(classes))] for j in range(max(classes))]
        for i in range(len(classes)):
            m[test[i]-1][classes[i]-1] = m[test[i]-1][classes[i]-1] + 1
        return m

def test():
    a = [i for i in range(100)]
    a = map(lambda i: i/20+1, a)
    print "A:", a

    arch = './sandboxC.txt.predict'

    easy = '../exps/easy.py'
    scanner = '../exps/sandboxS.txt'
    camera = '../exps/sandboxC.txt'

    cmd = '{0} {1} {2}'.format(easy, scanner, camera)
    print cmd
    f = Popen(cmd, shell = True).communicate()

    cmd = 'cat "{0}"'.format(arch)
    print cmd
    f = Popen(cmd, shell = True, stdout = PIPE).stdout

    test = [0 for i in range(101)]
    i = 0
    line = 1
    while True:
        last_line = line
        line = f.readline()
        test[i] = int(last_line)
        i = i+1
        if not line: break

    print "Test: ", test

    b = conf_mat(test,a)
    for row in b:
        print row
