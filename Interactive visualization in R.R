library(ggplot2)
g <- ggplot(txhousing, aes(x = date, y = sales, group = city)) +
  geom_line(alpha = 0.4)
g

head(txhousing)
library(plotly)
g <- ggplot(txhousing, aes(x = date, y = sales, group = city)) +
  geom_line(alpha = 0.4) 
ggplotly(g, tooltip = c("city"))
#However, plotly can be used as a stand-alone function (integrated with the magrittr piping syntax %>% rather than the ggplot + syntax), 
#to create some powerful interactive visualizations based on line charts, scatterplots and barcharts.
g <- txhousing %>% 
  # group by city
  group_by(city) %>%
  # initiate a plotly object with date on x and median on y
  plot_ly(x = ~date, y = ~median) %>%
  # add a line plot for all texan cities
  add_lines(name = "Texan Cities", hoverinfo = "none", 
            type = "scatter", mode = "lines", 
            line = list(color = 'rgba(192,192,192,0.4)')) %>%
  # plot separate lines for Dallas and Houston
  add_lines(name = "Houston", 
            data = filter(txhousing, 
                          city %in% c("Dallas", "Houston")),
            hoverinfo = "city",
            line = list(color = c("red", "blue")),
            color = ~city)
g
library(crosstalk)
# define a shared data object
d <- SharedData$new(mtcars)
# make a scatterplot of disp vs mpg
scatterplot <- plot_ly(d, x = ~mpg, y = ~disp) %>%
  add_markers(color = I("navy"))
# define two subplots: boxplot and scatterplot
subplot(
  # boxplot of disp
  plot_ly(d, y = ~disp) %>% 
    add_boxplot(name = "overall", 
                color = I("navy")),
  # scatterplot of disp vs mpg
  scatterplot, 
  shareY = TRUE, titleX = T) %>% 
  layout(dragmode = "select")


# make subplots
p <- subplot(
  # histogram (counts) of gear
  plot_ly(d, x = ~factor(gear)) %>% 
    add_histogram(color = I("grey50")),
  # scatterplot of disp vs mpg
  scatterplot, 
  titleX = T
) 
layout(p, barmode = "overlay")


install.packages("networkD3")
library(networkD3)
data(MisLinks, MisNodes)
head(MisLinks, 3)

head(MisNodes, 3)

forceNetwork(Links = MisLinks, Nodes = MisNodes, Source = "source",
             Target = "target", Value = "value", NodeID = "name",
             Group = "group", opacity = 0.9, Nodesize = 3, 
             linkDistance = 100, fontSize = 20)
