# Multivariate analysis

# Set the wd and the libraries
setwd("C:/lab/")
library(raster)
library(ggplot2)
library(viridis)
library(patchwork)

# Import images
sen <- brick("sentinel.png")
sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])
plot(sen2)
pairs(sen2) # Let's see the correlation between the bands

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000) # We created a sample
pca <- prcomp(sample)
summary(pca) 
# It gives us the information, standard deviation and amount of variability explained by each component,
# using the first component we already have 68% of explained variability
# The first two explain almost all the variability, 99.6%

# See the variability of the three components
plot(pca)

# Now we must predict the value of the other pixels
pci <- predict(sen2, pca, index=c(1:3)) # "index" represents how many components we want in the output
plot(pci)

# ggplot2
pcid1 <- as.data.frame(pci[[1]], xy=T) # ggplot wants tabular data and not raster

# Let's see how the first component for the fill is called
pci

ggplot() +
  geom_raster(pcid1, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis()
pcid3 <- as.data.frame(pci[[3]], xy=T) 
ggplot() +
  geom_raster(pcid3, mapping = aes(x=x, y=y, fill=PC3)) +
  scale_fill_viridis()

# "patchwork"
plot1 <- ggplot() +
  geom_raster(pcid1, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis() +
  ggtitle("Principal Component 1")

plot3 <- ggplot() +
  geom_raster(pcid3, mapping = aes(x=x, y=y, fill=PC3)) +
  scale_fill_viridis() +
  ggtitle("Principal Component 3")

plot1 + plot3

# Calculate the standard deviation of PC1 with the focal function
sd3 <- focal(pci[[1]], matrix(1/9, 3, 3), fun=sd)
sd3 # names = layer
sd3d <- as.data.frame(sd3, xy=T)

# Patchwork for PC1 and its standard deviation
plotsd <- ggplot() +
  geom_raster(sd3d, mapping = aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option="inferno") +
  ggtitle("Standard Deviation of PC1 (3x3)")

plot1 <- ggplot() +
  geom_raster(pcid1, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis(option="inferno") +
  ggtitle("Principal Component 1")

plot1 + plotsd
