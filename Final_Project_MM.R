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


# 3. Graph that correlates how many threatened or endaged species there are and then
#how many non-native species there are
