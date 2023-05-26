# 3D in R

setwd("C:/Lab/dati")
library(raster)
library(ggplot2)
library(viridis)
library(patchwork)

#importo l'immagine
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013

#creo un dataframe
dsm_2013d <- as.data.frame(dsm_2013, xy=T)
head(dsm_2013d)

#visualizziamo con ggplot
ggplot() +
  geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalElevationModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle("dsm 2013")

#creiamo adesso il modello del terreno
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
dtm_2013

dtm_2013d <- as.data.frame(dtm_2013, xy=T)
head(dtm_2013d)

#posso rinominare
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

#con patchwork
p1 + p2 + p3

