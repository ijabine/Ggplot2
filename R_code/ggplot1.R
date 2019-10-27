library(tidyverse)
library(cowplot)

imdb_5000 <- read_csv("data/imdb_5000.csv")
str(imdb_5000)


# Gross sales histogram ---------------------------------------------------
plot1 <- imdb_5000 %>% ggplot(aes(x = gross)) +
  geom_histogram(colour = 'black', fill = 'lightblue') +
  coord_cartesian(xlim = range(imdb_5000$gross, na.rm = TRUE))

# Gross sales boxplot, mean and sd ----------------------------------------
plot2 <- imdb_5000 %>% ggplot(aes(x = '',y = gross)) +
  geom_boxplot(fill = 'lightblue') +
  stat_summary(geom = 'pointrange', fun.data = mean_sdl, fun.args = list(mult = 1), 
               shape = 100, size = 1, colour = 'green') +
  coord_flip(ylim = range(imdb_5000$gross, na.rm = TRUE))


# Plot Grid ---------------------------------------------------------------

plot_grid(plot1,plot2,ncol = 1,align = 'v',rel_heights = c(0.6,0.4))
