library("kohonen")

breads <- read.csv('../data/clasificadorPostasameSize.csv',h=F)

breads <- breads[1:200,]
breads <- breads[-3]
breads <- breads[-41]

pca <- prcomp(breads,xret=T,scores=T,scale=T,center=T)

png("pca.png")
biplot(pca)
dev.off()
