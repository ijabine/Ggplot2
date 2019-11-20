library(tidyverse)
library(cowplot)


# Basics of ggplot2 -------------------------------------------------------
# The main components of the ggplot system:
# 1. Data to be visalized, must be dataframe
# 2. Aesthetics - defines what variables from the dataframe we are going to visualize, and in what way, meaning what is on x and y axes, the color, shape, size, etc.
# 3. Geom - geometrical elements used to visualize the data
#

# function ggplot() - creates the basis layer, it's just an empty grey zone, serving as the main area where we add other elements of the plot.
# to point ggplot() to a source of data, enter the following code: 
ggplot(data = mtcars) #ggplot works with data frames!
# to tell ggplot what data should be used from the dataframe, use aes() function:
ggplot(data = mtcars,aes(x = mpg,y = disp)) # in this case on x- axe we will have mpg variable, and on y-axe disp respetevely.
# now we need to tell ggplot how we want to represent this data, in this example we will use scatter plot. To another layer use + sign:
ggplot(data = mtcars,aes(x = mpg,y = disp)) +
  geom_point()
# to change the size, color and shape of the points, add color, size and shape to geom_point:
mtcars$cyl <- factor(mtcars$cyl)
ggplot(data = mtcars,aes(x = mpg,y = disp, shape = cyl, color = gear, size = carb)) +
  geom_point()
# less crammed plot, with fewer elements, perhaps more readable:
ggplot(data = mtcars,aes(x = mpg,y = disp, color = cyl)) +
  geom_point(size = 4, shape = 17)

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
