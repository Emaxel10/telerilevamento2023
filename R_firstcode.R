# My first code in Git Hub
# Let's install the raster package
install.packages("raster")
library(raster)

# Import data, setting the working directory
setwd("C:/lab/") # Windows
l2011 <- brick("p224r63_2011_masked.grd")
# "brick" function create a RasterBrick that is a multi-layer raster object, used to store all the data together 

# Plotting the data
plot(l2011)

# Create a color Ramp Palette to change the color of graphs
cl <- colorRampPalette(c("red", "orange", "yellow")) (100) # 100 are the shades
plot(l2011, col=cl)

# Plotting one element. We can use [[]] or $ to choose the element
plot(l2011[[4]], col=cl)
plot(l2011$B4_sre, col=cl)
nir <- l2011[[4]] # Or nir <- l2011$B4_sre
plot(nir, col=cl)

# Excersise: change the color gamut for all the images
cl2 <- colorRampPalette(c("aquamarine", "blue", "darkorchid4")) (100)
plot(l2011, col=cl2)

# Export graphs in R (as pdf)
pdf("myfirstgraphs.pdf")
plot(l2011, col=cl2)
dev.off() # dev.off() # It closes graphs

# Plotting several bands in a multiframe with the "par" function
par(mfrow = c(2,1))

# Plotting the first 4 layers / bands
par(mfrow = c(2,2))
# Blue
clb <- colorRampPalette(c("blue4", "blue", "lightblue")) (100)
plot(l2011[[1]], col=clb)
# Green
clg <- colorRampPalette(c("chartreuse4", "chartreuse2", "chartreuse")) (100)
plot(l2011[[2]], col=clg)
# Red
clr <- colorRampPalette(c("red", "darkred", "brown4")) (100)
plot(l2011[[3]], col=clr)
# Nir
clnir <- colorRampPalette(c("darkgoldenrod", "orange", "blueviolet")) (100)
plot(l2011[[4]], col=clnir)

# RGB plotting
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# Multiframe with natural and false colours
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Histogram stratching
par(mfrow = c(2,1))
plotRGB(l2011, 4, 3, 2, stretch="Hist")

# We use stretch to widen the colors. The linear stretch doesn't change the colors, 
# the one for histograms highlights the difference between minimum and maximum

# Excersise: import the 1988 image and replicate the process
l1988 <- brick("p224r63_1988_masked.grd")
l1988
plot(l1988)

# Plot RGB
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")

# Multiframe
par(mfrow = c(2,1))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")

# Exercise: making a multiframe with 2 rows and 2 columns, 1988 (stretch) lin, 2011 lin, 1988 hist, 2011 hist
# RGB with infrared in red
par(mfrow = c(2,2))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")
