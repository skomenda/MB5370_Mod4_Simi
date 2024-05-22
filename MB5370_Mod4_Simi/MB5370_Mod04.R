#-------------------------------------------------------------#
#MB5370 Module 4: Data Science in R ####
#14/05/2024
#Simi Komenda

#Script location 
#~/Documents/tech1/github_to_R.R 

#Description - 
#-------------------------------------------------------------#

#-------------------------------------------------------------#
#Workshop 1 Session 1 - Github ####

install.packages("usethis")
credentials::git_credential_ask()
usethis::git_sitrep()
usethis::use_github()
#-------------------------------------------------------------#

#-------------------------------------------------------------#

#Workshop 1 Session 2 - Data Viz in R ####
#visualizing scientific data in R

#load packages and data
#install tidyverse
library(tidyverse)

#data built-in data set provided in ggplot 
mpg #data frame
?mpg #learn more about the data set

#create first ggplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
# negative relationship between engine size (displ) and fuel efficiency (hxy). bigger cars use more fuel, therefore big cars are less fuel efficient 

#ggplot() creates a coordinate system that you can add layers to 
ggplot()
#the first argument is the dataset to use in graph (data = )
ggplot(data = mpg)
#geom_point() adds a layer of points to plot. always paired with aesthetics (aes()) and the x and y arguments od aes specifiy which variables to map on the x and y axes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#Understand the 'Grammar of Graphics' ####
#learn template:

# ggplot(data = <DATA>) + 
#  <geom_function>(mapping = aes(<mappings>))

#aesthetics include size, shape, and color
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))
#the classes of cars are now different colors 

#change point size by class
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#change point transparency by class (alpha) - helpful for point dense clouds 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

#change point shape by class 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#you can also set these properties manually 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")

#aesthetic other than variable name 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))
#values greater than 5 are 'true' and values less than 5 are 'false'

# Troubleshooting ####
#with all programming there will problems that you need to fix 

#ggplot(data = mpg) 
# +  geom_point(mapping = aes(x = displ, y = hwy))
# the + needs to be in the top line 

#there are loads of help pages if you get stuck 

# Facet and Panel Plots ####
#breaking a single complex plot into many sub plots (panels)
# often used to show subset of data 

#facet your plot using a single variable (facet_wrap() for discrete variables)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2) # ~ dictates which variable you want to subset your data with 

#Facet your data with more than 1 variable (facet_grid())
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl) # ~ separates the 2 variables 

#use a "." if you do not want to facet in the rows or column dimension 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

?facet_wrap
# nrow/ncol is the number of rows and columns

# Fitting Simple Lines ####

#display data as points 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#display the same data as a smooth line fit through the points use geom_smooth
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

#play around with different geom functions to see which one best represents your data
ggplot(data = mpg) + 
  #  geom_point(mapping = aes(x = displ, y = hwy)) #points horrible 
  geom_smooth(mapping = aes(x = displ, y = hwy)) #try smooth line

#change line type controlled by a variable 
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# use group argument to show that the data is grouped 
#set the group aesthetic to a categorical variable to draw multiple objects 
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

#Plot multiple geoms on a single plot 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
#duplicated so it is not efficient programming 

# same plot as before but is more efficient programming 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
         geom_point() +
         geom_smooth()
#same if you want to specify different data for each layer. use a filter (class = "subcompact") to select a subset pf the data and plot only for that subset
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

#Exercise:

#geoms and types of charts: 
# line: ggplot(mpg) + geom_smooth(aes(x,y))
# boxplot: ggplot(mpg,aes(class,hwy)) + geom_boxplot()
# histogram: ggplot(mpg,aes(hwy)) + geom_histogram(bandwidth)
# area chart: ggplot(mpg,aes(hwy)) + geom_area(stat = "bin")

#predictions: plot with displ on the x axis, hwy on the y axis with bith points and a trend line 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

#predictions: same as above 

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#they look identical but the code in the first one is more efficient 

# Transformations and Stats ####
# easy data transformations and data summaries

#Plotting Statistics
#bar chart shows that more diamonds are available with higher quality cuts 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
#plots bin counts when counts is not a variable (bar charts, histograms, and frequency)
#smothers fit a model to your data and then plot the predictions from the model
#box plots compute a robust summary of the distribution and then display a specially formatted box 

#can generally use geoms and stats interchangeably 
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

#Overriding defaults in ggplot2
#defaults are not thed only thing you can use 

#change the stat (count, a summary) to identity (raw value of variable)
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
demo

ggplot(data = demo) + 
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

# can also override default mapping from transformed variables to aesthetics
#proportion rather than a count 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

#plotting statistical details
# stat_summary - be transparent about uncertainty or other limitations in your data'
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# Aesthetic Adjustments ####
#use color and fill to change aspects of bar colors 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

#use these aesthetics to color by another variable
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
#stacking is done automatically - this is done bts with a position argument 
# the ability to make position adjustments is vital, it allows you customize your pplots in three ways, identity (raw data), fill(changes heights), and dodge (forces ggplot2 not to put things on top of each other)

#position = "identity" - you will be able to place each object exactly where it falls in the context of the graph
# vital for point charts (scatter plots) but makes things messy in a bar chart 

#To alter transparency (alpha)
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
#stacked and shaded different colors 

#To color the bar outlines with no fill color
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
#stacked and outlined in different colors 

#position = "fill" works like stacking but makes each set of stacked bars the same height 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
#all the same height but the clarity are different colors (I hate these)

#position = "dodge' places overlapping objects directly beside one another 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
#the clarity are beside each other instead of stack (my brain likes these)

# The Layered Grammar of Graphics ####
#updated template to make plots in ggplot2:

# ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(
#    mapping = aes(<MAPPINGS>),
#    stat = <STAT>, 
#    position = <POSITION>
#  ) +
#  <FACET_FUNCTION>

#-------------------------------------------------------------#

#-------------------------------------------------------------#
#Workshop 2 - Using ggplot2 for Communication #### 
#communicate the results of a graph by customizing plots

library(tidyverse)

# Labels ####
#add labels 

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size") #adds title to plot

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size", #adds title 
    subtitle = "Two seaters (sports cars) are an exception because of their weight", #adds subtitle
    caption = "Data from fueleconomy.gov" #adds caption 
)

#you can use labs() to replace axis labels and legend titles 
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)", #x axis label 
    y = "Highway fuel Economy (mpg)", #y axis label 
    color = "Car type" #color codes points 
)

# Annotations ####
# add text to the plot itself 
#geom_text() to ad textual labels to plot 
# we can also filter the data and add label that calls in values from the data frame 

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_text(aes(label = model), data = best_in_class)

# nudhe() allows you to move text a certain amount and using other R packages to handle text wrapping 

# Sacles ####
# #ggplot automatically adds scales 
# you can tweak the scale bar by offering up values (make sure to provide limits)
?scale_x_continuous #has plenty of other arguments 
# don't forget to to explicitly state the argument you-re providing limits for e.g. limits=c(0,12)
  
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  scale_x_continuous() +
  scale_y_continuous() + 
  scale_color_discrete()

# Axis Ticks ####
# you can change the ticks on your axis

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() + 
  scale_y_continuous(breaks = seq(15, 40, by = 5)) #y scale ranges from 15 to 40 in intervals of 5

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  scale_x_continuous(labels = NULL) + 
  scale_y_continuous(labels = NULL) # use NULL supress labels altogether

# Legends and color schemes ####
# change the position of legend and/or color scheme theme()

base <- ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class))

base + theme(legend.position = "left") #legend on left 
base + theme(legend.position = "right") #legend on right (default)
base + theme(legend.position = "top") #legend on top 
base + theme(legend.position = "bottom") #legend on bottom  
base + theme(legend.position = "none") #suppress legend display

#Replacing the scale ####
# two types of scales most likely to switch out: continuous position and color

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_bin2d() +
  scale_x_log10() +
  scale_y_log10() #log transforms scale

#color scale 
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = drv)) 

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  scale_color_brewer(palette = "Set1")

#if there are few colors, you can add redundant shape mapping. this will help ensure your plot is readable in black/white
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv, shape = drv)) + #color and shape coded
  scale_color_brewer(palette = "Set1")

#when you have predefined colors you want to use you can set them yourself using scale_color_manual()

presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, color = party)) + 
  geom_point() +
  geom_segment(aes(xend = end, yend = id)) +
  scale_color_manual(values = c(Republican = "red", Democratic = "blue"))

#scale_color_viridis() is a very popular color palette 
install.packages('viridis')
install.packages('hexbin')
library(viridis)
library(hexbin)

df <- tibble( #creating a fake dataset so we can plot it 
  x = rnorm(10000),
  y = rnorm(10000)
  )
ggplot(data = df, aes(x,y)) + 
  geom_hex() + #new
  viridis::scale_fill_viridis() + 
  coord_fixed()

# Themes ####
# customize theme of entire plot 
# ggplot has 8 themes by default 

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_light() #grid lines

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + 
  theme_classic() # blank background and no gridlines 

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_dark() #dark background and grid lines

#you can develop your own themes
theme (panel.border = element_blank(),
       panel.grid.minor.x = element_blank(),
       panel.grid.minor.y = element_blank(),
       legend.position="bottom",
       legend.title=element_blank(),
       legend.text=element_text(size=8),
       panel.grid.major = element_blank(),
       legend.key = element_blank(),
       legend.background = element_blank(),
       axis.text.y=element_text(colour="black"),
       axis.text.x=element_text(colour="black"),
       text=element_text(family="Arial")) 

# Saving and exporting plots ####
# ggsave() best function to save plots 
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class))

ggsave("my-plot.pdf") #> saving 7 x 4.32 in image 

# you can change the height and width with the arguments height and width 

#-------------------------------------------------------------#

#-------------------------------------------------------------#
# Workshop 3 - Data Wrangling in R ####
