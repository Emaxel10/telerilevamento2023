# Salve a tutti, sono Emanuele e questo è il mio progetto di esame per il corso di telerilevamento geo-ecologico del professor D. Rocchini.
# Il progetto paragona diverse immagini della costa dei Trabocchi in Abruzzo negli anni precedenti e successivi agli incendi del 2021.
# I dati sono presi del sito: https://scihub.copernicus.eu/

# Per prima cosa settiamo la working directory
setwd("C:/Progetto telerilevamento") # Windows

# Installiamo e richiamiamo i pacchetti necessari 
install.packages("raster")
install.packages("ggplot2")
install.packages("viridis")
install.packages("patchwork")
library(raster)
library(ggplot2)
library(viridis)
library(patchwork)

# Importiamo le immagini
# 2020
rlist1 <- list.files(pattern = "T33TVG_2020")
import1 <- lapply(rlist1, raster)
I2020 <- stack(import1)
# 2021
rlist2 <- list.files(pattern = "T33TVG_2021")
import2 <- lapply(rlist2, raster)
I2021 <- stack(import2)
# 2023
rlist3 <- list.files(pattern = "T33TVG_2023")
import3 <- lapply(rlist3, raster)
I2023 <- stack(import3)

# Le immagini sono troppo grandi quindi facciamo un crop e prendiamo in analisi solo l'area desiderata
ext <- c(438490, 477510, 4660680, 4697720)
CT2020 <- crop(I2020, ext)
CT2021 <- crop(I2021, ext)
CT2023 <- crop(I2023, ext)

# Facciamo un primo multiframe e plottiamo, via RGB, le 3 immagini per un primo confronto grafico
par(mfrow = c(1,3))
plotRGB(CT2020, 3, 2, 1, stretch="Lin")
plotRGB(CT2021, 3, 2, 1, stretch="Lin")
plotRGB(CT2023, 3, 2, 1, stretch="Lin")
dev.off()

# Ora



