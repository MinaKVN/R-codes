install.packages("remotes")
remotes::install_github("wilkelab/practicalgg")
library(tidyverse)
library(ggforce)   # for geom_arc_bar()
library(cowplot)   # for theme_map()

bundestag <- practicalgg::bundestag %>%
  select(party, seats, colors)
bundestag
ggplot(bundestag, aes(x = 1, y = seats, fill = party)) +
  geom_col() +
  coord_polar(theta = "y")
#We could try to style this pie chart to make it look the way we want, but I usually find it 
#easier to draw pie charts in cartesian coordinates, using geom_arc_bar() from ggforce. 
#This requires a little more data preparation up front but gives much more predictable results on the back end.

bund_pie <- bundestag %>%
  arrange(seats) %>%
  mutate(
    end_angle = 2*pi*cumsum(seats)/sum(seats),   # ending angle for each pie slice
    start_angle = lag(end_angle, default = 0),   # starting angle for each pie slice
    mid_angle = 0.5*(start_angle + end_angle),   # middle of each pie slice, for the text label
    # horizontal and vertical justifications depend on whether we're to the left/right
    # or top/bottom of the pie
    hjust = ifelse(mid_angle > pi, 1, 0),
    vjust = ifelse(mid_angle < pi/2 | mid_angle > 3*pi/2, 0, 1)
  )

bund_pie
# radius of the pie and radius for outside and inside labels
rpie <- 1
rlabel_out <- 1.05 * rpie
rlabel_in <- 0.6 * rpie

ggplot(bund_pie) +
  geom_arc_bar(
    aes(
      x0 = 0, y0 = 0, r0 = 0, r = rpie,
      start = start_angle, end = end_angle, fill = party
    )
  ) +
  coord_fixed()
#Next we add labels representing the numbers of seats for each party.

ggplot(bund_pie) +
  geom_arc_bar(
    aes(
      x0 = 0, y0 = 0, r0 = 0, r = rpie,
      start = start_angle, end = end_angle, fill = party
    )
  ) +
  geom_text(
    aes(
      x = rlabel_in * sin(mid_angle),
      y = rlabel_in * cos(mid_angle),
      label = seats
    ),
    size = 14/.pt # use 14 pt font size
  ) +
  coord_fixed()


#And we provide labels for the parties outside of the pie.

ggplot(bund_pie) +
  geom_arc_bar(
    aes(
      x0 = 0, y0 = 0, r0 = 0, r = rpie,
      start = start_angle, end = end_angle, fill = party
    )
  ) +
  geom_text(
    aes(
      x = rlabel_in * sin(mid_angle),
      y = rlabel_in * cos(mid_angle),
      label = seats
    ),
    size = 14/.pt
  ) +
  geom_text(
    aes(
      x = rlabel_out * sin(mid_angle),
      y = rlabel_out * cos(mid_angle),
      label = party,
      hjust = hjust, vjust = vjust
    ),
    size = 14/.pt
  ) +
  coord_fixed()

#We see that we need to make some space for the outside labels. We can do that by manually setting the scale limits and expansion.

ggplot(bund_pie) +
  geom_arc_bar(
    aes(
      x0 = 0, y0 = 0, r0 = 0, r = rpie,
      start = start_angle, end = end_angle, fill = party
    )
  ) +
  geom_text(
    aes(
      x = rlabel_in * sin(mid_angle),
      y = rlabel_in * cos(mid_angle),
      label = seats
    ),
    size = 14/.pt
  ) +
  geom_text(
    aes(
      x = rlabel_out * sin(mid_angle),
      y = rlabel_out * cos(mid_angle),
      label = party,
      hjust = hjust, vjust = vjust
    ),
    size = 14/.pt
  ) +
  scale_x_continuous(
    name = NULL,
    limits = c(-1.5, 1.4),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name = NULL,
    limits = c(-1.05, 1.15),
    expand = c(0, 0)
  ) +
  coord_fixed()

#Next we change the pie colors. The dataset provides appropriate party colors, and we use those directly with scale_fill_identity(). Note that this scale eliminates the legend. We don't need a legend anyways, because we have direct labeled the pie slices.

ggplot(bund_pie) +
  geom_arc_bar(
    aes(
      x0 = 0, y0 = 0, r0 = 0, r = rpie,
      start = start_angle, end = end_angle, fill = colors
    )
  ) +
  geom_text(
    aes(
      x = rlabel_in * sin(mid_angle),
      y = rlabel_in * cos(mid_angle),
      label = seats
    ),
    size = 14/.pt
  ) +
  geom_text(
    aes(
      x = rlabel_out * sin(mid_angle),
      y = rlabel_out * cos(mid_angle),
      label = party,
      hjust = hjust, vjust = vjust
    ),
    size = 14/.pt
  ) +
  scale_x_continuous(
    name = NULL,
    limits = c(-1.5, 1.4),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name = NULL,
    limits = c(-1.05, 1.15),
    expand = c(0, 0)
  ) +
  scale_fill_identity() +
  coord_fixed()

#The black color for the text labels doesn't work well on top of the dark fill colors, 
#and the black outline also looks overbearing, so we'll change those colors to white.

ggplot(bund_pie) +
  geom_arc_bar(
    aes(
      x0 = 0, y0 = 0, r0 = 0, r = rpie,
      start = start_angle, end = end_angle, fill = colors
    ),
    color = "white"
  ) +
  geom_text(
    aes(
      x = rlabel_in * sin(mid_angle),
      y = rlabel_in * cos(mid_angle),
      label = seats
    ),
    size = 14/.pt,
    color = c("black", "white", "white")
  ) +
  geom_text(
    aes(
      x = rlabel_out * sin(mid_angle),
      y = rlabel_out * cos(mid_angle),
      label = party,
      hjust = hjust, vjust = vjust
    ),
    size = 14/.pt
  ) +
  scale_x_continuous(
    name = NULL,
    limits = c(-1.5, 1.4),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name = NULL,
    limits = c(-1.05, 1.15),
    expand = c(0, 0)
  ) +
  scale_fill_identity() +
  coord_fixed()

#Finally, we need to apply a theme that removes the background grid and axes
ggplot(bund_pie) +
  geom_arc_bar(
    aes(
      x0 = 0, y0 = 0, r0 = 0, r = rpie,
      start = start_angle, end = end_angle, fill = colors
    ),
    color = "white"
  ) +
  geom_text(
    aes(
      x = rlabel_in * sin(mid_angle),
      y = rlabel_in * cos(mid_angle),
      label = seats
    ),
    size = 14/.pt,
    color = c("black", "white", "white")
  ) +
  geom_text(
    aes(
      x = rlabel_out * sin(mid_angle),
      y = rlabel_out * cos(mid_angle),
      label = party,
      hjust = hjust, vjust = vjust
    ),
    size = 14/.pt
  ) +
  scale_x_continuous(
    name = NULL,
    limits = c(-1.5, 1.4),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name = NULL,
    limits = c(-1.05, 1.15),
    expand = c(0, 0)
  ) +
  scale_fill_identity() +
  coord_fixed() +
  theme_map()