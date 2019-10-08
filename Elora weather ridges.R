library(dplyr)
library(ggridges)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(tidyverse)
library(ggridges)
library(awtools)
library(viridis)

data<- read_csv("Elora1.csv")

data$Month = factor(data$Month, levels = month.name)

ggplot(data, aes(x = `Mean Temp`, y = `Month` , fill = ..x..)) +
  geom_density_ridges_gradient(scale = 2, rel_min_height = 0.001, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [°C]", option = "C") +
  labs(title = 'Temperatures in Elora',
    subtitle = 'Mean temperatures (°C) by month for 2018'
  ) +theme_ipsum(grid=F)+
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())

ggplot(data, aes(x = `Mean.Temp`, y = `Month`, fill = ..x..)) + 
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 2.0) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [C]", option = "C") +
  labs(
    title = 'Temperatures in Lincoln NE',
    subtitle = 'Mean temperatures (Fahrenheit) by month for 2016\nData: Original CSV from the Weather Underground'
  ) +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank()) 

ggplot(data, aes(x = `Mean.Temp`, y = `Month`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis(name = "Temp. [F]", option = "C") +
  labs(title = 'Temperatures in Lincoln NE in 2016')
Month<-  factor(Month, levels =c("January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"), ordered = T)
data %>% 
mutate(Month) %>% 
  
library(ggjoy)
library(hrbrthemes)
data$month<-months(as.Date(data$CST))
weather.raw$months<-factor(rev(weather.raw$month),levels=rev(unique(weather.raw$month)))

#scales

data$month<-months(as.Date(data$CST))
data$months<-factor(rev(data$month),levels=rev(unique(data$month)))

#scales
mins<-min(data$Min.Temp)
maxs<-max(data$Max.Temp)

head(data)