library(tidyverse)
library(cowplot)


# Basics of ggplot2 -------------------------------------------------------
# The main components of the ggplot system:
# 1. Data 
# 2. Aesthetics
# 3. Geom
# 4. Coordinate system
# 5. Stats 
# 6. Scales
# 7. Faceting
# 8. Position Adjustments
# 9. Labels
# 10. Legends
# 12. Zooming
# 13. Themes
# I would say that 1 - 3 are the most often used.
# For more info see ggplot cheat sheet: ggplot2/manuals/ggplot2-cheatsheet.pdf 

# 1. Data - (variables from a dataframe) to be visalized, must be dataframe, to call: data =

# Creation of a plot starts with the call to function ggplot(). This function creates the basis layer, it's just an empty grey zone, serving as the main area where we add other elements of the plot.
# To tell ggplot what source of data to use, enter the data = as an argument of ggplot(): 
ggplot(data = mtcars) #ggplot works with dataframes!


# 2. Aesthetics - defines what variables from the dataframe we are going to visualize, and in what way, meaning what is on x and y axes, the color, shape, size, etc. Function call aes()

# To tell ggplot what data (variables) should be used (or "mapped" to graphical elements) from the dataframe, use aes() function:
ggplot(data = mtcars,aes(x = mpg,y = disp)) # in this case on x- axe we will have mpg variable, and on y-axe disp respetevely.
# We might want to tell ggplot how we would like to represent this data, in this example we will use scatter plot. This is so-called geom and it's another element of the plot which is represented by a layer. To add another layer (element) use + sign:
ggplot(data = mtcars,aes(x = mpg,y = disp)) +
  geom_point()
# To change the size, color and shape of the points, add color, size and shape as aes() arguments:
mtcars$cyl <- factor(mtcars$cyl)
ggplot(data = mtcars,aes(x = mpg,y = disp, shape = cyl, color = gear, size = carb)) +
  geom_point() # in this example the shape of points will depend on number of cylenders, color on the number of gears and size on carb variables. When we specify various aesthetics elements in ggplot() main function they become default for all subsequent layers. However, we can define aesthetics only for "geom_point" layer like this (the result will look the same as the previous plot):

ggplot(data = mtcars) +
  geom_point(aes(x = mpg,y = disp, shape = cyl, color = gear, size = carb))

# less crammed plot, with fewer elements, perhaps more readable:
ggplot(data = mtcars,aes(x = mpg,y = disp, color = cyl)) +
  geom_point(size = 4, shape = 17)


# 3. Geom - geometrical elements (or primitives) used to visualize the data, called with a family of geom_ functions (e.g. geom_point, geom_histogram, etc.)

# Here is a list of geoms available in ggplot:

# geom_abline	Reference lines: horizontal, vertical, and diagonal
# geom_area	Ribbons and area plots
# geom_bar	Bar charts
# geom_bin2d	Heatmap of 2d bin counts
# geom_blank	Draw nothing
# geom_boxplot	A box and whiskers plot (in the style of Tukey)
# geom_col	Bar charts
# geom_contour	2d contours of a 3d surface
# geom_count	Count overlapping points
# geom_crossbar	Vertical intervals: lines, crossbars & errorbars
# geom_curve	Line segments and curves
# geom_density	Smoothed density estimates
# geom_density2d	Contours of a 2d density estimate
# geom_density_2d	Contours of a 2d density estimate
# geom_dotplot	Dot plot
# geom_errorbar	Vertical intervals: lines, crossbars & errorbars
# geom_errorbarh	Horizontal error bars
# geom_freqpoly	Histograms and frequency polygons
# geom_hex	Hexagonal heatmap of 2d bin counts
# geom_histogram	Histograms and frequency polygons
# geom_hline	Reference lines: horizontal, vertical, and diagonal
# geom_jitter	Jittered points
# geom_label	Text
# geom_line	Connect observations
# geom_linerange	Vertical intervals: lines, crossbars & errorbars
# geom_map	Polygons from a reference map
# geom_path	Connect observations
# geom_point	Points
# geom_pointrange	Vertical intervals: lines, crossbars & errorbars
# geom_polygon	Polygons
# geom_qq	A quantile-quantile plot
# geom_qq_line	A quantile-quantile plot
# geom_quantile	Quantile regression
# geom_raster	Rectangles
# geom_rect	Rectangles
# geom_ribbon	Ribbons and area plots
# geom_rug	Rug plots in the margins
# geom_segment	Line segments and curves
# geom_sf	Visualise sf objects
# geom_sf_label	Visualise sf objects
# geom_sf_text	Visualise sf objects
# geom_smooth	Smoothed conditional means
# geom_spoke	Line segments parameterised by location, direction and distance
# geom_step	Connect observations
# geom_text	Text
# geom_tile	Rectangles
# geom_violin	Violin plot
# geom_vline	Reference lines: horizontal, vertical, and diagonal

# Very usefull feature is to save a plot in a variable and then add elements as needed
bar_plot <- ggplot(data = mtcars,aes(x = cyl))
bar_plot <- bar_plot + geom_bar(fill = 'red', colour = 'black')
# to visualize the plot just call the variable bar_plot:
bar_plot


# 4. Coordinate system: to understand what is depicted on the plot it must have a coordinate system. Cartesian coordinate system (combining y and x dimensions orthogonally) is probably the most widely used one. Using coord_ family of function you can do various manipulations with the coordinate system 
# Here is a list of coord_ functions:

# coord_cartesian	Cartesian coordinates
# coord_equal	Cartesian coordinates with fixed "aspect ratio"
# coord_fixed	Cartesian coordinates with fixed "aspect ratio"
# coord_flip	Cartesian coordinates with x and y flipped
# coord_map	Map projections
# coord_polar	Polar coordinates
# coord_quickmap	Map projections
# coord_sf	Visualise sf objects
# coord_trans	Transformed Cartesian coordinate system

# We can zoom in and out data by calling coord_cartesian(xlim = lim, ylim = lim):

base_plot <- ggplot(data = mtcars,aes(x = mpg,y = disp)) +
  geom_point()
base_plot + coord_cartesian(xlim = 20, ylim = 150) # Please note by zooming we are not changing the underlying data, but just their depiction.





# 5. Stats 



# 6. Scales - 

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
