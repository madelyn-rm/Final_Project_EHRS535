# Group Project ERHS 535 : Invasive Species in the Top 15 National Parks

This group project involved creating an interactive and visually engaging flexdashboard using RMarkdown. The project was a collaborative effort, with team members dividing responsibilities for designing the framework and developing the visualizations.The work here illustrates the prevalence of the various invasive species found in the top 15 most visited National parks in the USA.

The data for this analysis was sourced from the [Tidy Tuesday GitHub repository](https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/2024-10-08). The data was collected by the [National Park Services ](https://irma.nps.gov/NPSpecies/Search/SpeciesList). The information in NPSpecies is available to the public for more detailed information on the dataset, here is the [Glossary](https://irma.nps.gov/content/npspecies/Help/docs/NPSpecies_User_Guide.pdf) for column names, field options, and tag meanings. 

The parks in this analysis include:
1. Acadia National Park 
2. Bryce Canyon National Park
3. Cuyahoga Valley National Park
4. Glacier National Park 
5. Grand Canyon National Park 
6. Grand Teton National Park
7. Great Smoky Mountains National Park
8. Hot Springs National Park
9. Indiana Dunes National Park
10. Joshua Tree National Park
11. Olympic National Park
12. Rocky Mountain National Park 
13. Yellowstone National Park
14. Yosemite National Park 
15. Zion National Park

Plot 1: National Parks Non-native Species Explorer


Plot 2: Correlating Biodiversity, Non-Native Influence, and Visitor Impact Across National Parks
This plot


Addtional Data used: [Park visit and regions data](https://www.responsible-datasets-in-context.com/posts/np-data/)



Plot 3: Mapping the Spread of Invasive Species Across National Parks

Installation:

```{r}
# Core Data Manipulation and Visualization
library(tidyverse)  # Includes ggplot2, dplyr, tidyr, etc.
library(ggplot2)    # Visualization
library(ggthemes)   # Thematic enhancements for ggplot2
library(tidyr)      # Data tidying and reshaping
# Advanced Visualizations
library(pheatmap)   # Heatmap generation
library(viridis)    # Color scales for ggplot2 and other plots
library(plotly)     # Interactive visualizations

# Data Input and Scaling
library(readxl)     # Reading Excel files
library(scales)     # Scaling functions for plots

# Interactive Dashboards
library(shiny)      # Interactive web applications
library(leaflet)    # Interactive maps

```



Acknowledgments:

Plot 1: 
Plot 2: Laura Moore 
Plot 3: Madelyn 
Flexboard set up and README: Danara Flores




 