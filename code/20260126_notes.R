# Notes from R Lesson on Jan 26, 2026
## Goals: To learn how to plot in R with ggplot2

# load packages 
library(tidyverse)

# load data 
sample_data <- read_csv("data/sample_data.csv")

# Summarize Data 

sample_data %>%
  summarize(mean_cells = mean(cells_per_ml),
            max_cells = max(cells_per_ml), 
            min_cells = min(cells_per_ml))



# No inputs/arguments needed
getwd()
Sys.Date()

# Some other functions require input 
sum(24, 26)
round(digits = 3, x = 3.1415) # ?round

# Plot 
ggplot(data = sample_data) +
  # temp vs cells in Lake Ontario? 
  aes(x = temperature, y = cells_per_ml,
      color = env_group, size = chlorophyll) + 
  # Let's update the labels of the plot to be more understandable 
  labs(x = "Temperature (C)", y = "Cells per mL", 
       title = "Does temperature affect microbial abundance?", 
       color = "Environmental Group", size = "Chlorophyll (ug/L)") + 
  # Plot points 
  geom_point()


# Load in new data
buoy_data <- read_csv("buoy_data.csv")
dim(buoy_data) # rows, columns 
head(buoy_data)

# Plot: day_of_year on x-axis; temp on y-axis
ggplot(data = buoy_data) + 
  aes(x = day_of_year, y = temperature,
      color = depth, group = sensor) + 
  geom_line() + 
  facet_wrap(~buoy)

# What is the structure of the data? 
str(buoy_data)








 