# 3D in R

# Set up libraries and wd
setwd("C:/Lab/dati")
library(raster)
library(ggplot2)
library(viridis)
library(patchwork)

# Import the image
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013

# Create a dataframe
dsm_2013d <- as.data.frame(dsm_2013, xy=T)
head(dsm_2013d)

# Plot via ggplot2
ggplot() +
  geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalElevationModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle("dsm 2013")

# Let's now create the terrain model
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
dtm_2013

dtm_2013d <- as.data.frame(dtm_2013, xy=T)
head(dtm_2013d) # The head() function in R is used to display the first n rows present in the input data frame

# Now we can rename and plot it
names(dtm_2013d) <- c("x", "y", "z")

ggplot()+
  geom_raster(dtm_2013d, mapping=aes(x=x, y=y, fill=z)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("dtm 2013")

p1 <- ggplot() +
  geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalElevationModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle("dsm 2013")

p2 <- ggplot()+
  geom_raster(dtm_2013d, mapping=aes(x=x, y=y, fill=z)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("dtm 2013")

p3 <-ggplot()+
  geom_raster(chm2013d, mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis() +
  ggtitle("dtm 2013")

# With patchwork
p1 + p2 + p3

