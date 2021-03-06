library("kohonen")

breads <- read.csv("som1.txt", sep=" ", h=F)
breads <- breads[-3]

set.seed(1)
     
training <- sample(nrow(breads), 100)
Xtraining <- scale(breads[training, -41])

grid = somgrid(10, 10, "hexagonal")
som.breads <- som(Xtraining, grid)


png("som.multifractal.png")
kohonen::plot.kohonen(som.breads, type = "mapping", label = breads[training,41], col = breads[training,41]+1, main = "")
dev.off()

breads <- read.csv("som2.txt", sep=" ", h=F)

set.seed(2)
     
training <- sample(nrow(breads), 100)
Xtraining <- scale(breads[training, -4])

grid = somgrid(10, 10, "hexagonal")
som.breads <- som(Xtraining, grid)


png("som.rgb.png")
kohonen::plot.kohonen(som.breads, type = "mapping", label = breads[training,4], col = breads[training,4]+1, main="")
dev.off()
