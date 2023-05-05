setwd("C:/lab/")
library(raster)
library(ggplot2)
library(viridis)
library(patchwork)
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
pci <- predict(sen2, pca, index=c(1:3)) # index rappresenta quante componenti vogliamo in uscita
plot(pci)
# usiamo ggplot per dei grafici migliori
pcid1 <- as.data.frame(pci[[1]], xy=T) # ggplot vuole dati tabellari e non raster
pci # vediamo come si chiama la prima componente per il fill
ggplot() +
  geom_raster(pcid1, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis()
pcid3 <- as.data.frame(pci[[3]], xy=T) 
ggplot() +
  geom_raster(pcid3, mapping = aes(x=x, y=y, fill=PC3)) +
  scale_fill_viridis()
# adesso con patchwork li mettiamo uno accanto all'altro
plot1 <- ggplot() +
  geom_raster(pcid1, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis() +
  ggtitle("Principal Component 1")
plot3 <- ggplot() +
  geom_raster(pcid3, mapping = aes(x=x, y=y, fill=PC3)) +
  scale_fill_viridis() +
  ggtitle("Principal Component 3")
plot1 + plot3
# calcoliamo la deviazione standard di PC1 con la funzione focal
sd3 <- focal(pci[[1]], matrix(1/9, 3, 3), fun=sd)
sd3 # names = layer
sd3d <- as.data.frame(sd3, xy=T)
#patchwork per PC1 e la sua deviazione standard
plotsd <- ggplot() +
  geom_raster(sd3d, mapping = aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option="inferno") +
  ggtitle("Standard Deviation of PC1 (3x3)")
plot1 <- ggplot() +
  geom_raster(pcid1, mapping = aes(x=x, y=y, fill=PC1)) +
  scale_fill_viridis(option="inferno") +
  ggtitle("Principal Component 1")
plot1 + plotsd
