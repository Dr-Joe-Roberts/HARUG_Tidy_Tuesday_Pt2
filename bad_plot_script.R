## Setup - install and load packages
if (!require(devtools)) install.packages("devtools")
if (!require(tidyverse)) install.packages("tidyverse")
library(devtools)
library(tidyverse)

## Get data
food_consumption <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-18/food_consumption.csv')

## Data preparation
co2_emission_by_country <- food_consumption %>%  # Create new data object
  group_by(country) %>% # Group data by country
  summarise(co2_emission = sum(co2_emmission)) %>% # Calculate total emissions for each country
  arrange(desc(co2_emission)) %>% # Arrange data by CO2 emissions in descending order
  mutate(rank = row_number())  # Create a new variable ranking data

co2_emission_uk <- co2_emission_by_country %>%  # Create new data object
  filter(country == "United Kingdom")  # Filter data to include only UK

co2_emission_tb <- rbind(head(co2_emission_by_country, 10), # Bind top 10 rows
                         tail(co2_emission_by_country, 10), # Bind bottom 10 rows
                         co2_emission_uk)  # Bind UK only rows

## Plot data
ggplot(co2_emission_tb, aes(x = country, y = co2_emission)) +  # Select axis variables
  geom_col() +  # Select plot type
  labs(x = "", y = "CO2 emissions")  # Axis labels
