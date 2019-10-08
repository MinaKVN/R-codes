#install following packages first using install.packages()

library(ggplot2)
library(reshape2)
library(ggpubr)
library(tidyverse)
library(ggsignif)

#two years of heading date for genotypes with 5 copy number variation 
data <- read.csv("D1.csv", header=T)
head(data)
data.m <- melt(data, id.vars = "PPD_D1")
head (data.m)
q <- ggplot(data = data.m, aes(x=variable, y=value, fill = PPD_D1)) + 
  geom_point(position = position_jitterdodge()) +
  geom_boxplot(alpha=0.7, size= 0.6)
# if you want color for points replace group with colour=Label
q <- q + xlab("year") + ylab("heading date GDD")
q <- q + guides(fill=guide_legend(title= "PPD_B1 CNV" ))
q <- q + theme(axis.line = element_line(colour = "black", size = 0.75),
               panel.grid.major = element_blank(),
               panel.grid.minor = element_blank(),
               panel.border = element_blank(),
               panel.background = element_blank())
q <- q + theme(axis.title.x = element_text(face='bold',size=12,hjust=0.5),
               axis.title.y = element_text(face='bold',size=12,vjust=2),
               axis.text.x = element_text(face='bold',size=10,color='black'),
               axis.text.y = element_text(face='bold',size=10,color='black'),
               legend.title = element_text(face="bold.italic", color="black", size=10),
               legend.text = element_text(face="bold", color="black", size=10))
q <- q+ scale_y_continuous(limits = c(300,710))
q <- q+scale_fill_brewer(palette="Set2")
q 



########### second graph
#heading dates and 3 ppd-B1 type 
data <- read.csv("C.csv", header=T)
head(data)
p <- ggplot(data = data, aes(x=PPD_D1, y=heading))
p <- p + geom_boxplot(aes(fill=PPD_D1), width=0.4, size= 0.6)
p <- p + geom_jitter(alpha=0.4, width = 0.2, size= 1.75, shape= 16)
p <- p + xlab("PPD_B1 type") + ylab("heading date GDD") 
p <- p + guides(fill=guide_legend(title="PPD_B1 type"))
p <- p + theme(axis.line = element_line(colour = "black", size = 0.75),
               panel.grid.major = element_blank(),
               panel.grid.minor = element_blank(),
               panel.border = element_blank(),
               panel.background = element_blank())
p <- p + theme(axis.title.x = element_text(face='bold.italic',size=12,hjust=0.5),
               axis.title.y = element_text(face='bold',size=12,vjust=2),
               axis.text.x = element_text(face='bold',size=10,color='black'),
               axis.text.y = element_text(face='bold',size=10,color='black'),
               legend.title = element_text(face="bold.italic", color="black", size=11),
               legend.text = element_text(face="bold", color="black", size=10))
# you can try other themes such as Paired, Purples, Greys ... 
p <- p+scale_fill_brewer(palette="Set2")
p

