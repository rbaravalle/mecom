import sys

if (len(sys.argv) < 2):
    print "Usage: " + sys.argv[0] + " matlab_data_file"
    exit(1)

f = open(sys.argv[1])

for l in f.readlines():
    co = 0
    for w in l.split(" "):
        
        w = w.strip("\n")
        w = w.strip(" ")
        
        if len(w.split(":")) > 1:
            while int(w.split(":")[0]) <> co + 1:
                print 0,
                co = co + 1
            
            print w.split(":")[1],
            co = co + 1
        else:
            cl = w
            
    print cl
