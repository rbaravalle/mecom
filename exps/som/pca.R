library("kohonen")

breads <- read.csv("train_clasificador.txt", sep=" ", h=F)
breads <- breads[-3]
breads <- breads[-41]

a = princomp(breads)

png("pca.png")
biplot(a)
dev.off()


breads <- breads[,1:10]

a = princomp(breads)

png("pca_resumen.png")
biplot(a)
dev.off()
