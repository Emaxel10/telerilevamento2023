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

# list f files:
rlist <- list.files(pattern="lst")
rlist
