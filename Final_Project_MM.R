library(tidyverse)
library(ggthemes)
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(pheatmap)
library(viridis)
library(plotly)

most_visited_nps_species_data <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-08/most_visited_nps_species_data.csv")

name_lists<- unique(most_visited_nps_species_data$ParkName) %>% 
print()




# 1. Map of invasive animals  


# 2. Heat map invasive species vs national parks 


# Preparing the data
invasive_data <- most_visited_nps_species_data %>%
  filter(Nativeness == "Non-native") %>%
  filter(!(CategoryName %in% c("Crab/Lobster/Shrimp", "Spider/Scorpion", "Protozoa"))) %>%  # Excluding categories with no observations
  select(ParkName, CategoryName, References) %>%
  mutate(ParkName = str_remove(ParkName, " National Park$")) %>%  # Remove "National Park" at the end of the name
  group_by(ParkName, CategoryName) %>%
  summarize(TotalReferences = sum(References, na.rm = TRUE), .groups = 'drop')

# Some National Parks don't have data for certain categories
# Creating a complete dataset with all combinations of ParkName and CategoryName
all_combinations <- expand_grid(
  ParkName = unique(invasive_data$ParkName),
  CategoryName = unique(invasive_data$CategoryName)
)

# Merging with the existing data and filling missing combinations with 0 so that it can be colored
invasive_data <- all_combinations %>%
  left_join(invasive_data, by = c("ParkName", "CategoryName")) %>%
  mutate(TotalReferences = replace_na(TotalReferences, 0))  # Replace NAs with 0

# Calculating total references by category to sort by density of observations
category_totals <- invasive_data %>%
  group_by(CategoryName) %>%
  summarize(TotalReferences = sum(TotalReferences, na.rm = TRUE)) %>%
  arrange(desc(TotalReferences))  # Sort by total references

# Reorder categories based on density
invasive_data <- invasive_data %>%
  mutate(CategoryName = factor(CategoryName, levels = rev(category_totals$CategoryName))) 

# Plot using geom_raster with viridis color palette and use original TotalReferences in hover text
heatmap <- ggplot(invasive_data, aes(
  x = ParkName,
  y = CategoryName,
  fill = log1p(TotalReferences),
  text = paste("Total References:", TotalReferences)
)) +
  geom_raster() +
  scale_fill_viridis_c(
    option = "rocket",
    direction = -1,  # Reverse the palette for clarity
    name = "Documented References\n(Log Scale)"
  ) +
  labs(
    title = "Distribution of Invasive Species Across National Parks",
    x = "National Park",
    y = ""
  ) +
  theme_tufte() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 12),  # Rotate and increase size of x-axis labels
    axis.text.y = element_text(size = 12),  # Increase size of y-axis labels
    plot.title = element_text(hjust = 0.5, size = 16),  # Center and enlarge title
    axis.title.x = element_text(size = 14),  # Increase size of x-axis title
    panel.grid = element_blank()  # Remove grid lines
  )


# Convert ggplot to plotly so that it is interactive
interactive_plot <- ggplotly(heatmap, tooltip = c("x", "y", "text"))
print(interactive_plot)

# 3. Graph that correlates how many threatened or endangered species there are and then
# how many non-native species there are. Size of points is size of national park,
# also include how many visitors there are per area of national park (color)

nps_species <- most_visited_nps_species_data
library(plotly)
library(viridis)
library(readxl)
library(scales)

visits <- read_csv("https://raw.githubusercontent.com/melaniewalsh/responsible-datasets-in-context/main/datasets/national-parks/US-National-Parks_RecreationVisits_1979-2023.csv")
regions <-  read_csv("https://raw.githubusercontent.com/melaniewalsh/responsible-datasets-in-context/main/datasets/national-parks/US-National-Parks_RecreationVisits_1979-2023.csv")
acres <- read_xlsx("data/NPS-Acreage-03-31-2024.xlsx", skip = 1)

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

# editing visitor data

visits <- visits %>% 
  separate(col = ParkName,
           into = c("ParkName", "NP"),
           sep = "NP") %>% 
  mutate(ParkName = str_trim(ParkName),
         NP = "National Park") %>% 
  mutate(ParkName = paste(ParkName, NP, sep = " ")) %>% 
  select(ParkName, RecreationVisits) %>% 
  filter(ParkName %in% unique(nps_species$ParkName)) %>% 
  group_by(ParkName) %>% 
  nest() %>% 
  mutate(avg_visits = map(data, .f = sum)) %>% 
  unnest() %>% 
  mutate(avg_visits = avg_visits/45) %>% # 45--number of years per park surveyed
  select(ParkName, avg_visits)
  
# regions data 
regions <- regions %>% 
  separate(col = ParkName,
           into = c("ParkName", "NP"),
           sep = "NP") %>% 
  mutate(ParkName = str_trim(ParkName),
         NP = "National Park") %>% 
  mutate(ParkName = paste(ParkName, NP, sep = " ")) %>% 
  select(ParkName, Region) %>% 
  filter(ParkName %in% unique(nps_species$ParkName)) %>% 
  group_by(Region, ParkName) %>% 
  count()

# acreage data
acres <- acres %>% 
  select(`Area Name`, `Gross Area Acres`) %>% 
  filter(str_detect(`Area Name`, pattern = "NP")) %>% 
  rename(ParkName = `Area Name`, 
         area = `Gross Area Acres`) %>% 
  mutate(ParkName = str_to_title(ParkName)) %>% 
  separate(col = ParkName,
           into = c("ParkName", "Np"),
           sep = "Np") %>% 
  mutate(ParkName = str_trim(ParkName),
         NP = "National Park") %>% 
  mutate(ParkName = paste(ParkName, NP, sep = " ")) %>% 
  filter(ParkName %in% unique(nps_species$ParkName) |
           str_detect(ParkName, "Smoky") |
           str_detect(ParkName, "Rocky")) %>% 
  select(ParkName, area)

acres$ParkName <- replace(acres$ParkName, 7, 
                          "Great Smoky Mountains National Park")
acres$ParkName <- replace(acres$ParkName, 12, 
                          "Rocky Mountain National Park")

# merging the visits, regions, and nps datasets

et_nn_species <- et_nn_species %>% 
  full_join(visits, by = "ParkName") 

et_nn_species <- et_nn_species %>% 
  full_join(regions, by = "ParkName")

et_nn_species <- et_nn_species %>% 
  full_join(acres, by = "ParkName")

# making it so there's only one row per park
et_nn_species_single <- et_nn_species %>% 
  select(ParkName, et_count, nn_count, avg_visits, Region, area) %>% 
  group_by(ParkName, et_count, nn_count, avg_visits, Region, area) %>% 
  count()
  
# plotting

#the_plot <- ggplot(et_nn_species_single, aes(x = et_count, y = nn_count, 
                           # size = avg_visits, color = log10(area))) +
 # geom_point() +
  #viridis::scale_color_viridis(discrete = FALSE) +
  #scale_size_continuous(
   # name = "Number of Visitors\nPer Year",
   # breaks = c(2e6, 3e6, 5e6, 8e6),
   # labels = c("2x10^6", "3x10^6", "5x10^6", "8x10^6")) +
 # theme_classic() +
 # labs(x = "Number of Endangered Species", y = "Number of Non-Native Species", 
     #  color = "log10(Area)", 
      # title = "Number of Non-Native and Endangered Species by Park") +
 # guides(size = guide_legend())

plot_ly(et_nn_species_single, x = ~et_count, y = ~nn_count, size = ~avg_visits,
        color = ~log10(area),
        text = ~paste("<b>Park:</b> ", ParkName, 
                      "<br><b>Avg. Visitors:</b> ", 
                      signif(avg_visits/1000, digits = 4), "k",
                      "<br><b>Region:</b> ", Region)) %>% 
        layout(title = "Non-Native vs. Endangered and Threatened Species", 
               plot_bgcolor = "lightblue1", 
               xaxis = list(title = "Number of Endangered and Threatened Species"),
               yaxis = list(title = "Number of Non-Native Species"))



