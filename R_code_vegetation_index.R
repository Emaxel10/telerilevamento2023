# Calculating spectral indices

library(raster)
setwd("C:/lab/") 

# Excersise: import defor1_.png
l1992 <- brick("defor1_.png")
l1992

# Excersise: plot the image via plotRGB
plotRGB(l1992, 3, 2, 1, stretch="Lin")

# What is NIR?
# NIR = 1
# RED = 2
# GREEN = 3

# Excersise: calculate DVI for 1992
dvi1992 = l1992[[1]] - l1992[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl)
# DVI is a Difference Vegetation Index. This index distinguishes between soil and vegetation

# Importing defor2_.png
l2006 <- brick("defor2_.png")
l2006

# Plotting the image via plotRGB
plotRGB(l2006, 1, 2, 3, stretch="Lin")

# Excersise: plot the image from 1992 on top of that of 2006
par(mfrow = c(2,1))
plotRGB(l1992, 1, 2, 3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

# Excersise: plot the image from 1992 beside of that of 2006
par(mfrow = c(1,2))
plotRGB(l1992, 1, 2, 3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

# Calculating the DVI for 2006
dvi2006 = l2006[[1]] - l2006[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi2006, col=cl)

# Multitemporal analysis
difdvi = dvi1992 - dvi2006
cld <- colorRampPalette(c("blue", "white", "red"))(100)
plot(difdvi, col=cld)

# Range DVI (8 bit): -255 a 255
# Range NDVI (8 bit): -1 a 1

# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1

# Hence, NDVI can be used to compare images with a different radiometric resolution

# NDVI 1992
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
plot(ndvi1992, col=cl)

# NDVI 2006
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])
plot(ndvi2006, col=cl)

difndvi = ndvi1992 - ndvi2006
plot(difndvi, col=cld)

