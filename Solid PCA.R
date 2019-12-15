#solid PCA

library("ggplot2")
library("factoextra")
library("FactoMineR")

data <- read.csv("CG.csv")
head(data)
my_data <- PCA(data[, 4:5], graph = TRUE)

p <- fviz_pca_biplot(
  my_data,
  # Fill individuals by groups
  geom.ind = "point",
  pointshape = 21,
  pointsize = 2.5,
  fill.ind = data$CG,
  col.ind = "grey27",
  addEllipses = TRUE, ellipse.level=0.9,
  # Color variable by groups
  col.var = factor(
    c("Collength",
      "Rootlength")),
  
  legend.title = list(fill = "CG"),
  repel = TRUE        # Avoid label overplotting
) +
  ggpubr::fill_palette("dose") +      # Indiviual fill color
  ggpubr::color_palette("npg")      # Variable colors
p <- print(p + ggtitle("CG"))
p