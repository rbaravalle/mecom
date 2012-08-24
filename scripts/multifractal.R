t1<-proc.time();
library("ReadImages");

img <- read.jpeg('/home/rodrigo/l1.jpg');

img <- rgb2grey(img);

l = 4; #window size

N <- dim(img);
Nx <- N[1];
Ny <- N[2];

eps <- .Machine$double.eps
img2 <- matrix(0,Nx,Ny);
measure <- rep(0,l);

f = function(i,j) {
    a <- i - k;
    b <- i + k;
    c <- j - k;
    d <- j + k;     
    if( a < 1 ) a <- 1;
    if( c < 1 ) c <- 1;
    if( b > Nx ) b <- Nx;
    if( d > Ny ) d <- Ny;
    return (c(a,b,c,d));
}

h = function(v) {
   return (max(img[a:b,c:d]));
}

for (i in 1:Nx) {
    for (j in 1:Ny) {
        v <- f(i,j);
        a <- v[1];
        b <- v[2];
        c <- v[3];
        d <- v[4];
        #for (k in 1:l) {           
            #measure[k] = max(img[v[1]:v[2],v[3]:v[4]]);
        #}
        measure = lapply(1:l,h);
        img2[i,j] = (coef(lm(log(2*1:l - 1) ~ log(measure+eps))))[1];
    }
}

maxx = max(img2);
minn = min(img2);
time <- (proc.time()-t1)[3];
