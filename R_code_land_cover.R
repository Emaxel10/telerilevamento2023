library(raster)
# install.packages("ggplot2")
library(ggplot2)
# install.packages("patchwork")
library(patchwork) # for multiframe ggplot plotting
setwd("C:/lab/) # Windows

defor1 <- brick("defor1_.png")
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")

defor2 <- brick("defor2_.png")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1, 2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# 1. Get all the single values
singlenr1 <- getValues(defor1)
singlenr1

# 2. Classify
kcluster1 <- kmeans(singlenr1, centers = 2)
kcluster1

# 3. Set values to a raster on the basis of so
defor1class <- setValues(defor1[[1]], kcluster1$cluster)
dev.off()
plot(defor1class)
# Class 1: forest
# Class 2: bare soil

# Classification of defor2
singlenr2 <- getValues(defor2)
singlenr2

kcluster2 <- kmeans(singlenr2, centers = 2)
kcluster2

defor2class <- setValues(defor2[[1]], kcluster2$cluster)
plot(defor2class)
# Class 1: forest
# Class 2: bare soil

# Frequencies
frequencies1 <- freq(defor1class)
tot1 <- ncell(defor1class)
percentages1 <- frequencies1 * 100 /  tot1
percentages1
# 89.7% forest, 10.3% bare soil

frequencies2 <- freq(defor2class)
tot2 <-  ncell(defor2class)
percentages2 <-  frequencies2 * 100 /  tot2
percentages2
# 52% forest, 48% bare soil

# Final table
cover <- c("Forest","Bare Soil")
percent_1992 <- c(89.7, 10.3)
percent_2006 <- c(52.0, 47.0)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

# let's plot them!
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
p1+p2

# Same range
