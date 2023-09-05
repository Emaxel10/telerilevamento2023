# Time series analysis

library(raster)

setwd("C:/lab/greenland") # Windows
# setwd("~/lab/greenland") # Linux
# setwd("/Users/name/Desktop/lab/greenland") # Mac

# Importing and plotting the images
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

# We can use list.files() to select files by pattern
rlist <- list.files(pattern="lst")
rlist

# "lapply" function helps us in applying functions on list objects and returns a list object of the same length
import <- lapply(rlist,raster)
import

# "stack" function is used to transform data available in the form of separate columns within a data frame or a list into a single column
TGr <- stack(import)
TGr
plot(TGr)

plotRGB(TGr, 1, 2, 3, stretch="Lin")

# Difference:
dift = TGr[[2]] - TGr[[1]]
plot(dift)

# levelplot(TGr)
cl <- colorRampPalette(c("blue","lightblue","pink","red"))(100)
plot(TGr, col=cl)

#--------------------------

# Excersise 2: European NO2

setwd("C:/Lab/EN")

# Importing and plotting a file
en01 <- raster("EN_0001.png")
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en01, col=cl)

# Exercise: import the whole as in the Greenland example
# by the following steps: list.files, lapply, stack

rlist <- list.files(pattern="EN")

# lapply(X,FUN)
rimp <- lapply(rlist, raster)

# "stack"
en <- stack(rimp)

# Plot everything
plot(en, col=cl)

# Check 1
par(mfrow = c(1,2))
plot(en01, col=cl)
plot(en[[1]], col=cl)

# Check 2
difcheck <- en01 - en[[1]]
difcheck
plot(difcheck)

# Exercise: plot EN01 besides EN13
par(mfrow=c(1,2))
plot(en[[1]], col=cl)
plot(en[[13]], col=cl)

# Let's make the difference:
difen <-  en[[1]] - en[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(difen, col=cldif)

# "plotRGB" of three files together
plotRGB(en, r=1, g=7, b=13, stretch="Lin")
plotRGB(en, r=1, g=7, b=13, stretch="Hist")
