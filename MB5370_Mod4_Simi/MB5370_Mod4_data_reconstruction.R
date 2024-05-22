#-----------------------------------------------------#
#MB5370 Module 4: Assessment 2 - Data Reconstruction
#14.05.2024

#Simi Komenda

#Script Location 
#~/Documents/skomenda_github/MB5370_Mod4_Simi/MB5370_Mod4_data_reconstruction.R

#Description - deconstructing and reconstructing a published plot using R
#-----------------------------------------------------#

#-----------------------------------------------------#

#upload data
<<<<<<< HEAD
fish_abundance <- read.csv("data/fish_abundace.csv")
trophic_guilds <- read.csv("~/Documents/tech1/tropic_guilds.csv")
=======
>>>>>>> 70e3b94 (workflow for workshops 1 and 2 of module 4)

library(tidyverse)
#create plot for fish abundance 
#point range plot plot, x = species, y = mean Fish per 40 m2 separate by site +- SD

?geom_pointrange
<<<<<<< HEAD
ggplot(data = fish_abundance) + 
  geom_pointrange(mapping = aes(x = Fish.Species, y = Fish.per.40m2, ymin = Fish.per.40m2-Standard.Deviation, ymax = Fish.per.40m2+Standard.Deviation, color = Site, shape = Site), position = position_dodge(width = 1, preserve = "total")) + 
  theme_classic() +         #blank background no gridlines, shapes for each of the two different site 
  scale_color_brewer(palette = "Set1") +  
  labs(x = "Fish Species", y = "Fish per 40m2") +
  scale_y_continuous(breaks = seq(0, 80, by = 10)) + # added more scale incriminates
  theme(axis.text.x = element_text(angle = -40, vjust = 0.5, hjust = .10))



  
?position_dodge()


=======
ggplot(data = fish_abundance1) + 
  geom_pointrange(mapping = aes(x = Fish.Species, y = Fish.per.40m2, ymin = Fish.per.40m2-Standard.Deviation, ymax = Fish.per.40m2+Standard.Deviation, color = Site), position = "jitter") +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  labs(x = "Fish Species", y = "Fish per 40m2")
  
>>>>>>> 70e3b94 (workflow for workshops 1 and 2 of module 4)

#fix a axis labels, differentiate between sites 

#---------------------------------------------------#

#---------------------------------------------------#

#create plot for trophic guilds
#bar plot, x = trphic guilds, y = relative abundance

 
