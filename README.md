# Group Project ERHS 535 : Invasive Species in the Top 15 National Parks

This work illustrates the prevalence of the invasive species found in the top 15 most visited National parks in the USA. The parks include:
1. Acadia National Park 
2. Bryce Canyon National Park
3. Cuyahoga Valley National Park
4. Rocky Mountain National Park 
5. Hot springs National Park 





The Data

# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-10-08')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 41)

most_visited_nps_species_data <- tuesdata$most_visited_nps_species_data

# Option 2: Read directly from GitHub

most_visited_nps_species_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-08/most_visited_nps_species_data.csv')






The data set that was used for this work comes from  [National Park Species](https://irma.nps.gov/NPSpecies/Search/SpeciesList.). The information in NPSpecies is available to the publicfor more detailed information on the dataset, here is the [Glossary](https://irma.nps.gov/content/npspecies/Help/docs/NPSpecies_User_Guide.pdf) for column names, field options, and tag meanings. 



 