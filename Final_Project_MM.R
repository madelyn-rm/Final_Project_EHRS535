library(tidyverse)
library(ggthemes)
library(readr)
most_visited_nps_species_data <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-08/most_visited_nps_species_data.csv')

# 1. Map of invasive animals  


# 2. Heat map animals vs national parks 


# 3. Graph that correlates how many threatened or endangered species there are and then
# how many non-native species there are. Size of points is size of national park,
# also include how many visitors there are per area of national park (color)

nps_species <- most_visited_nps_species_data
library(plotly)

# endangered, threatened, extinct, 
# proposed similarity of appearance (threatened), 
# Experimental, nonessential populations of endangered species
et_nn_species <- nps_species %>% 
  filter(TEStatus %in% c("E", "T", "D3A", "PSAT", "E, EXPN") |
           Nativeness == "Non-native")

ggplot(et_nn_species, aes(x = ))





