# Group Project ERHS 535 : Invasive Species in the Top 15 National Parks

This group project involved creating an interactive and visually engaging flexdashboard using RMarkdown. The project was a collaborative effort, with team members dividing responsibilities for designing the framework and developing the visualizations.The work here illustrates the prevalence of the various invasive species found in the top 15 most visited National parks in the USA.

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

## Sourced Data
These data for the analysis were sourced from the [Tidy Tuesday GitHub repository](https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/2024-10-08). The data was collected by the [National Park Services ](https://irma.nps.gov/NPSpecies/Search/SpeciesList). The information in NPSpecies is available to the public for more detailed information on the dataset, here is the [Glossary](https://irma.nps.gov/content/npspecies/Help/docs/NPSpecies_User_Guide.pdf) for column names, field options, and tag meanings.  

Addtional Data used for plot 2: [Park visit and regions data](https://www.responsible-datasets-in-context.com/posts/np-data/)

## Plot 1: National Parks Non-native Species Explorer
The interactive plot features a map of the United States highlighting the locations of the 15 most visited National Parks. By clicking on a park, users can uncover the top 10 most frequently reported non-native species specific to that location, providing a way to explore and compare the impact of non-native species across these parks.

## Plot 2: Correlating Biodiversity, Non-Native Influence, and Visitor Impact Across National Parks
The interactive scatter plot reveals the correlation between the prevalence of non-native species and visitor impact across National Parks, with each data point representing a park. The size and color of the dots correspond to a log10 scale of park area, providing additional context. Hovering over a point displays the park's name and its average number of visitors. This allows users to explore the relationship between biodiversity and visitation patterns in these parks.

## Plot 3: Mapping the Spread of Invasive Species Across National Parks
The heat map portrays the patterns of invasive species across National Parks. The visualization highlights vascular plants as the most prevalent invasive group, followed by birds while amphibions were the least invasive species in all the parks. This representation underscores the ecological challenges posed by these species and provides valuable insights into their distribution trends across protected areas.

## Installation: How to run
1. Download the Data folder:
Clone or download the repository and extract it to your computer and ensure the data file is in the same directory as the .Rmd file. This folder contains all necessary datasets for rendering the flexdashboard.

2. Render the flexdashboard
Download the .Rmd file: Test Flexdashboard.Rmd. Open the dashboard.Rmd file in RStudio.

3. Install Required Packages
Open RStudio and install the required R packages 
```
# Core Data Manipulation and Visualization
install.packages(tidyverse)  # Includes ggplot2, dplyr, tidyr, etc.
install.packages(ggthemes)   # Thematic enhancements for ggplot2
# Advanced Visualizations
install.packages(pheatmap)   # Heatmap generation
install.packages(viridis)    # Color scales for ggplot2 and other plots
install.packages(plotly)     # Interactive visualizations
# Data Input and Scaling
install.packages(readxl)     # Reading Excel files
install.packages(scales)     # Scaling functions for plots
# Interactive Dashboards
install.packages(shiny)      # Interactive web applications
install.packages(leaflet)    # Interactive maps
```
4. Click the run document button at the top of the script editor.
The dashboard will render and open in your default web browser.

Acknowledgments:
1. Jered May: Plot 1
2. Laura Moore: Plot 3
3. Madelyn Maclaughlin: Plot 2
4. Danara Flores:Framework design and ReadME




 