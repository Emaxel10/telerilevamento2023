# R code for species distribution modeling

install.packages("sdm")
library(sdm)
install.packages("rgdal", dependencies=T)
library(rgdal)
library(raster)

# Store, into "file", the data downloaded as shapefile (shp)
file <- system.file("external/species.shp", package="sdm")
file
species <- shapefile(file)
species

# 0 absence, 1 presence
plot(species, pch=19)

# Represent all occurrences, both 0 and 1
# Now we only plot the presences
presences <- species[species$Occurrence == 1, ] # Let's make a sample
plot(presences, col="blue", pch=19)
absences <- species[species$Occurrence == 0, ]
plot(absences, col="red", pch=19)

# Plot them together
plot(presences, col="blue", pch=19)
points(absences, col="red", pch=19)

# Predictors, environmental variables
path <- system.file("external", package = "sdm")

# Importing the predictors
list <- list.files(path=path, pattern = 'asc$', full.names = T)
list
preds <- stack(list)
preds
plot(preds)

# Using a color Ramp Palette
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# Plot predictors and occurrences
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# Using temperature
plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# Precipitation
plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# Vegetation
plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# Linear model
# Explain to the model the data to use
# Ground data is called training data
datasdm <- sdmData(train=species, predictors=preds)
datasdm
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")

# Raster output layer
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1, ], pch=16)

# Add to the stack
s1 <- stack(preds,p1)
names(s1)[5] <- "model"
plot(s1, col=cl)
