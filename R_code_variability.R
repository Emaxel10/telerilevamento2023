# Variability

# Set the working durectory and the libraries
setwd("C:/lab/")
library(raster)
library(ggplot2)
library(patchwork)

# Let's install viridis package for different color maps
install.packages("viridis")

# Import the image
sen <- brick("sentinel.png")

# Band 1 = NIR
# Band 2 = red
# Band 3 = green

# Plot via RGB
plotRGB(sen, 1, 2, 3, stretch="Lin")
nir <- sen[[1]]
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # sd = standand deviation

# Plotting with ggplot2
ggplot() +
  geom_raster(sd3, mapping=aes(x = x, y = y, fill = layer))
# Error, we need a dataframe

# Create the dataframe, then we can use ggplot2
sd3d <- as.data.frame(sd3, xy=T)
ggplot() +
  geom_raster(sd3d, mapping=aes(x = x, y = y, fill = layer))

# Now we can change the color and give a title to our plot
# Viridis
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# Cividis
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# Magma
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# Inferno
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")

# Use patchwork package to combine separate ggplots into the same graphic
p1 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation via the viridis colour scale")

p2 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation via the inferno colour scale")

p1 + p2

# Excersise: plot the original image (NIR) and its standard deviation
nird <- as.data.frame(nir, xy=T)
p3 <- ggplot() +
  geom_raster(nird, mapping =aes(x=x, y=y, fill=sentinel_1)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("NIR via the cividis colour scale")
p3
p3 + p1
