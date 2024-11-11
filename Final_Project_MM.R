library(tidyverse)
library(sf)
library(tigris)
library(raster)

nps_species <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-08/most_visited_nps_species_data.csv')
nps_centroid <- read_csv('/Users/madelynmaclaughlin/Downloads/R_class/Final_Project_EHRS535/data/nps_centroid.csv')
boundaries <- shapefile('/Users/madelynmaclaughlin/Downloads/R_class/Final_Project_EHRS535/data/boundaries/nps_boundary/nps_boundary.shp')

nps_species %>% 
  filter(References == c(0, 1),
         CategoryName == "Mammal") %>% 
  View()





