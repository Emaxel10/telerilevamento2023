setwd("C:/lab/")
library(raster)
library(ggplot2)
sen <- brick("sentinel.png")
sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])
plot(sen2)
pairs(sen2) # Vediamo la correlazione tra le bande
# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000) # abbiamo creato un campione
pca <- prcomp(sample)
summary(pca) # ci dà le informazioni, deviazione standar e quantità di variabilità spiegata da ogni componente
#usando la prima componenete abbiamo già il 68% di variabilità spiegata
#le prime due spiegano quasi tutta la variabilità, il 99.6%
plot(pca) #vediamo le variabilità delle tre componenti
#dobbiamo prevedere ora il valore degli altri pixel
pci <- predict(sen2, pca, index=c(1:3)) #index rappresenta quante componenti vogliamo in uscita
plot(pci)
