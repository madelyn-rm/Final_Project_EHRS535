library(tidyverse)
library(ggthemes)
library(readr)
library(dplyr)

most_visited_nps_species_data <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-08/most_visited_nps_species_data.csv")



# 1. Map of invasive animals  


# 2. Heat map invasive species vs national parks 
#x-axis will be national parks, y-axis will be kingdom (category name)

invasive_data <- most_visited_nps_species_data %>% 
  select(ParkName, CategoryName, Nativeness, Observations)


# 3. Graph that correlates how many threatened or endangered species there are and then
# how many non-native species there are. Size of points is size of national park,
# also include how many visitors there are per area of national park (color)

nps_species <- most_visited_nps_species_data
library(plotly)

# endangered, threatened, extinct, 
# proposed similarity of appearance (threatened), 
# Experimental, nonessential populations of endangered species

et_species <- et_nn_species %>% 
  filter(TEStatus %in% c("E", "T", "D3A", "PSAT", "E, EXPN")) %>% 
  group_by(ParkName) %>% 
  summarize(et_count = n())
           
nn_species <- et_nn_species %>% 
  filter(Nativeness == "Non-native") %>% 
  group_by(ParkName) %>% 
  summarize(nn_count = n())





