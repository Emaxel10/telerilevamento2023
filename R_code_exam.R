# Salve a tutti, sono Emanuele e questo è il mio progetto di esame per il corso di telerilevamento geo-ecologico del professor D. Rocchini.
# Il progetto paragona diverse immagini della costa dei Trabocchi in Abruzzo negli anni precedenti e successivi agli incendi del 2021.
# I dati sono presi del sito: https://scihub.copernicus.eu/

# Per prima cosa settiamo la working directory
setwd("C:/Progetto telerilevamento") # Windows

# Installiamo e richiamiamo i pacchetti necessari 
install.packages("raster")
install.packages("ggplot2")
install.packages("patchwork")
library(raster)
library(ggplot2)
library(patchwork)

# ----- Importazione e visualizzazione -----

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

# Dopo aver visualizzato le immagini in colori reali usiamo la banda del NIR al posto della rossa per evidenziare la vegetazinoe
plotRGB(CT2020, 4, 3, 2, stretch="Lin")
plotRGB(CT2021, 4, 3, 2, stretch="Lin")
plotRGB(CT2023, 4, 3, 2, stretch="Lin")

# ----- Indici spettrali -----

# È arrivato il momento di calcolare gli indici spettrali 

# DVI (Difference Vegetation Index)
# DVI = NIR - Red
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
dvi2020 = CT2020[[4]] - CT2020[[3]]
dvi2021 = CT2021[[4]] - CT2021[[3]]
dvi2023 = CT2023[[4]] - CT2023[[3]]

# NDVI (Normalized Difference Vegetation Index)
# NDVI = (NIR - Red)/(NIR + Red) = DVI/(NIR + Red)
ndvi2020 = dvi2020 / (CT2020[[4]] + CT2020[[3]])
ndvi2021 = dvi2021 / (CT2021[[4]] + CT2021[[3]])
ndvi2023 = dvi2023 / (CT2023[[4]] + CT2023[[3]])

# Una volta calcolati gli NDVI possiamo plottarli
par(mfrow = c(1,3))
plot(ndvi2020, col=cl)
plot(ndvi2021, col=cl)
plot(ndvi2023, col=cl)
dev.off()

# Calcolo le differenze di NDVI tra il 2020 e il 2023
cld <- colorRampPalette(c("blue", "white", "red"))(100)
difndvi = ndvi2020 - ndvi2023
plot(difndvi, col=cld)

# ----- Classificazione -----

# Classificazione e calcolo delle percentuali
# 2020
singler20 <- getValues(CT2020)
singler20
kcluster20 <- kmeans(singler20, centers = 3)
kcluster20
class2020 <- setValues(CT2020[[3]], kcluster20$cluster)
plot(class2020)

frequencies2020 <- freq(class2020)
frequencies2020
total2020 <- ncell(class2020)
total2020
percentages2020 = frequencies2020 * 100 /  total2020
percentages2020

#             value    count
# [1,] 2.075692e-05 42.99239 # Acqua 
# [2,] 6.918975e-06 16.31916 # Suolo bruciato 
# [3,] 1.383795e-05 40.68845 # Vegetazione 

# 2021
singler21 <- getValues(CT2021)
singler21
kcluster21 <- kmeans(singler21, centers = 3)
kcluster21
class2021 <- setValues(CT2021[[3]], kcluster21$cluster)
plot(class2021)

frequencies2021 <- freq(class2021)
frequencies2021
total2021 <- ncell(class2021)
total2021
percentages2021 = frequencies2021 * 100 /  total2021
percentages2021

#             value    count
# [1,] 6.918975e-06 42.94496 # Acqua
# [2,] 1.383795e-05 20.98822 # Suolo bruciato
# [3,] 2.075692e-05 36.06682 # Vegetazione


# 2023
singler23 <- getValues(CT2023)
singler23
kcluster23 <- kmeans(singler23, centers = 3)
kcluster23
class2023 <- setValues(CT2023[[3]], kcluster23$cluster)
plot(class2023)

frequencies2023 <- freq(class2023)
frequencies2023
total2023 <- ncell(class2023)
total2023
percentages2023 = frequencies2023 * 100 /  total2023
percentages2023

#             value    count
# [1,] 6.918975e-06 42.90857 # Acqua
# [2,] 1.383795e-05 17.65770 # Suolo bruciato 
# [3,] 2.075692e-05 39.43373 # Vegetazione

# Mettiamo insieme in un grafico tutte le percentuali per poterle comparare
cover <- c("Acqua", "Vegetazione", "Suolo bruciato")
percentuale_20 <- c(42.99, 40.69, 16.32)
percentuale_21 <- c(42.94, 36.07, 20.99)
percentuale_23 <- c(42.91, 39.43, 17.66)
percentages <- data.frame(cover, percentuale_20, percentuale_21, percentuale_23)

# 2020
p1 <- ggplot(percentages, aes(x = cover, y = percentuale_20, color = cover)) +
  geom_bar(stat = "identity", fill = "white") +
  ggtitle("2020") +
  ylim(c(0, 100))

# 2021
p2 <- ggplot(percentages, aes(x = cover, y = percentuale_21, color = cover)) +
  geom_bar(stat = "identity", fill = "white") +
  ggtitle("2021") +
  ylim(c(0, 100))

# 2023
p3 <- ggplot(percentages, aes(x = cover, y = percentuale_23, color = cover)) +
  geom_bar(stat = "identity", fill = "white") +
  ggtitle("2023") +
  ylim(c(0, 100))

p1 + p2 + p3






