setwd("C:/lab/")
library(raster)
library(ggplot2)
install.packages("viridis")
library(viridis)
library(patchwork)
sen <- brick("sentinel.png")
# Band 1 = NIR
# Band 2 = red
# Band 3 = green
plotRGB(sen, 1, 2, 3, stretch="Lin")
nir <- sen[[1]]
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) #sd = standand deviation
# plotting with ggplot2
ggplot() +
  geom_raster(sd3, mapping=aes(x = x, y = y, fill = layer))
# error, we need a dataframe
sd3d <- as.data.frame(sd3, xy=T)
ggplot() +
  geom_raster(sd3d, mapping=aes(x = x, y = y, fill = layer))
  # with viridis
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# cividis
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# magma
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# inferno
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")

# patchwork
p1 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation via the viridis colour scale")

p2 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation via the inferno colour scale")

p1 + p2
