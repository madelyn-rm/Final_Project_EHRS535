library(tidyverse)
library(ggthemes)
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(pheatmap)

most_visited_nps_species_data <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-08/most_visited_nps_species_data.csv")



# 1. Map of invasive animals  


# 2. Heat map invasive species vs national parks 
#x-axis will be national parks, y-axis will be kingdom (category name)

invasive_data <- most_visited_nps_species_data %>% 

  filter(Nativeness == "Non-native") %>% 
  select(ParkName, CategoryName, References) %>% 
  group_by(ParkName, CategoryName) %>% 
  summarize(TotalReferences = sum(References, na.rm = TRUE)) %>% 
  ungroup() %>% 
  pivot_wider(names_from = ParkName, values_from = TotalReferences, values_fill = 0) %>% 
  column_to_rownames("CategoryName")

log_transform_data <- log1p(as.matrix(invasive_data))


pheatmap(
  as.matrix(log_transform_data),           
  color = colorRampPalette(c("white", "red"))(50), 
  border_color = NA,                 
  main = "Invasive Species References by National Park and Category",
  fontsize_row = 8,                 
  fontsize_col = 8,                  
  angle_col = 45                    
)

  select(ParkName, CategoryName, Nativeness, Observations)


# 3. Graph that correlates how many threatened or endangered species there are and then
# how many non-native species there are. Size of points is size of national park,
# also include how many visitors there are per area of national park (color)

nps_species <- most_visited_nps_species_data
library(plotly)
library(viridis)

# endangered, threatened, extinct, 
# proposed similarity of appearance (threatened), 
# Experimental, nonessential populations of endangered species

et_species <- nps_species %>% 
  filter(TEStatus %in% c("E", "T", "D3A", "PSAT", "E, EXPN")) %>% 
  group_by(ParkName) %>% 
  summarize(et_count = n())
           
nn_species <- nps_species %>% 
  filter(Nativeness == "Non-native") %>% 
  group_by(ParkName) %>% 
  summarize(nn_count = n())

et_nn_species <- et_species %>% 
  full_join(nn_species, by = "ParkName")

ggplot(et_nn_species, aes(x = et_count, y = nn_count, color = ParkName)) +
  geom_point() +
  scale_color_viridis(discrete = TRUE) +
  theme_classic()





