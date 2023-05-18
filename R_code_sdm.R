# R code for species distribution modeling
install.packages("sdm")
library(sdm)
install.packages("rgdal", dependencies=T)
library(rgdal)
library(raster)
file <- system.file("external/species.shp", package="sdm")
file
species <- shapefile(file)
species
# 0 assenza, 1 presenza
plot(species, pch=19)
# rappresentano tutte le occorrenze, sia 0 che 1
# ora plottiamo solo le presenze
presences <- species[species$Occurrence == 1, ] # faccio un campione
plot(presences, col="blue", pch=19)
absences <- species[species$Occurrence == 0, ]
plot(absences, col="red", pch=19)
# plottiamoli insieme
plot(presences, col="blue", pch=19)
points(absences, col="red", pch=19)
# predittori, variabili ambientali 
path <- system.file("external", package = "sdm")
# importiamo i predittori insieme
list <- list.files(path=path, pattern = 'asc$', full.names = T)
list
preds <- stack(list)
preds
plot(preds)
# usiamo una color ramp palette
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)
# plot predictors and occurrences
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# usiamo la temperatura ora
plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# precipitation
plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)
# vegetation
plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# modello lineare
# spiegare al modello i dati da utilizzare
# i dati a terra si chiamano training data
datasdm <- sdmData(train=species, predictors=preds)
datasdm
# alt 1 2 6 per la tilde
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
# raster output layer
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1, ], pch=16)
# aggiungiamo allo stack
s1 <- stack(preds,p1)
plot(s1, col=cl)
