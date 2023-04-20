# Classification of remote sensing via RStoolBox
# Installing devtools
# install.packages("devtools")
# library(devtools)
# devtools::install_github("bleutner/RStoolbox")

setwd("C:/lab/")

# Data import
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist")

# Classifying the solar data

# 1) Get all the single values
singlenr <- getValues(so)
singlenr
#
# set.seed(99)

# 2) Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3) Set values to a raster on the basis of so
soclass <- setValues(so[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)

# set.seed can be used for repeating the experiment in the same manner for N times

#####

# Grand Canyon

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc

# rosso = 1
# verde = 2
# blu = 3

plotRGB(gc, r=1, g=2, b=3, stretch="lin")

# Change the stretch to histogram stretching
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# Classification

# 1) Get values
singlenr <- getValues(gc)
singlenr

# 2) Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3) Set values
gcclass <- setValues(gc[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(gcclass, col=cl)
# Class 1: vulcanic rocks
# Class 2: sandstone
# Class 3: conglomerates

frequencies <- freq(gcclass)
frequencies
total <- ncell(gcclass)
total
percentages = frequencies * 100 /  total
percentages
