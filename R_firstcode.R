# My first code in Git Hub
# Let's install the raster package

install.packages("raster")

library(raster)

# Import data, setting the working directory
setwd("C:/lab/") #windows

l2011 <- brick("p224r63_2011_masked.grd")

# plotting the data
plot(l2011)

cl <- colorRampPalette(c("red", "orange", "yellow")) (100) # 100 sono le sfumature
plot(l2011, col=cl)

# plotting one element
plot(l2011[[4]], col=cl)

plot(l2011$B4_sre, col=cl)

nir <- l2011[[4]] # or nir <- l2011$B4_sre
plot(nir, col=cl)

# Excersise: change the colour gamut for all the images
cl2 <- colorRampPalette(c("aquamarine", "blue", "darkorchid4")) (100)
plot(l2011, col=cl2)

# dev.off() # it closes graphs

# Export graphs in R
pdf("myfirstgraphs.pdf")
plot(l2011, col=cl2)
dev.off()

# plotting several bands in a multiframe
par(mfrow = c(2,1))

# plotting the first 4 layers / bands
par(mfrow = c(2,2))
# blue
clb <- colorRampPalette(c("blue4", "blue", "lightblue")) (100)
plot(l2011[[1]], col=clb)
# green
clg <- colorRampPalette(c("chartreuse4", "chartreuse2", "chartreuse")) (100)
plot(l2011[[2]], col=clg)
# red
clr <- colorRampPalette(c("red", "darkred", "brown4")) (100)
plot(l2011[[3]], col=clr)
# nir
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
plotRGB(l2011, r=3, g=2, b=1, stretch="Hist")
plotRGB(l2011, r=3, g=2, b=4, stretch="Hist")
