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

# Generate the heatmap
pheatmap(
  as.matrix(log_transform_data),           
  color = colorRampPalette(c("white", "red"))(50), 
  border_color = NA,                 
  main = "Invasive Species Observations by National Park and Category",
  fontsize_row = 8,                 
  fontsize_col = 8,                  
  angle_col = 45                    
)


# 3. Graph that correlates how many threatened or endaged species there are and then
#how many non-native species there are
