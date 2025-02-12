# Data Analysis 

# Load packages
library(tidyverse)

# Grab the data for our analysis
sample_data <- read_csv("data/sample_data.csv")
glimpse(sample_data)

# Summarize - Summary stats on our metadata 
summarize(sample_data, avg_cells = mean(cells_per_ml))

# Syntax/style 
sample_data %>%
  # Group the data by environmental group
  group_by(env_group) %>%
  # Calculate the mean 
  summarize(avg_cells = mean(cells_per_ml))

# Filter: Subset data by rows based on some value 
sample_data %>%
  # subset samples only from the deep 
      # Why two equal signs? We will subset based on a logical, TRUE == 1  
  filter(temperature < 5) %>%
  #filter(env_group == "Deep") %>%
  # calculate the mean cell abundances 
  summarize(avg_cells = mean(cells_per_ml))
            
# Mutate(): Create a new column
sample_data %>%
  # Calc new column with the TN:TP ratio
  mutate(tn_tp_ratio = total_nitrogen / total_phosphorus) %>%
  # visualize it 
  View()

# select(): Subset by entire columns
sample_data %>%
  # pick specific columns 
  select(-c(diss_org_carbon, chlorophyll))


# Clean up data 

