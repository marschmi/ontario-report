# Plotting Lake Ontario Microbial Cell Abundances 
# By: Mar Schmidt 
# Date: January 29th, 2025 

# First install the packages 
install.packages("tidyverse")
library(tidyverse)

# Load in the data 
?read_csv
sample_data <- read_csv(file = "sample_data.csv")

Sys.Date() # What is the date? 
getwd() # Where am I? 

sum(2, 3)

# What does our data look like? 
str(sample_data)

# Plotting! 
ggplot(data = sample_data) +
  aes(x = temperature, y = cells_per_ml/1000000, 
      color = env_group, size = chlorophyll) + 
  labs(x = "Temp (C)", y = "Cell Abundance (millions/mL)",
       title = "Does temperature affect microbial abundance?",
       color = "Environmental Group", size = "Chlorophyll (ug/L)") + 
  geom_point() 



ggplot(data = sample_data) +
  aes(x = total_nitrogen, y = cells_per_ml/1000000, 
      color = env_group, size = temperature) + 
  labs(#x = "Temp (C)", 
       y = "Cell Abundance (millions/mL)",
       #title = "Does temperature affect microbial abundance?",
       color = "Environmental Group", 
       #size = "Chlorophyll (ug/L)"
       ) + 
  geom_point() +
  theme_bw()



# BUOY DATA 
buoy_data <- read_csv(file = "buoy_data.csv")
dim(buoy_data)
glimpse(buoy_data)
length(unique(buoy_data$sensor))


# Plot the buoy data 
ggplot(data = buoy_data) + 
  aes(x = day_of_year, y = temperature, group = sensor,
      color = depth) + 
  geom_line()

# Facet plot 
ggplot(data = buoy_data) + 
  aes(x = day_of_year, y = temperature, group = sensor,
      color = depth) + 
  geom_line() + 
  facet_grid(rows = vars(buoy))


# Cell abundances by environmental group 
ggplot(data = sample_data) + 
  aes(x = env_group, y = cells_per_ml, 
      color = env_group, fill = env_group) + 
  geom_jitter(aes(size = chlorophyll)) +
  geom_boxplot(alpha = 0.3, outlier.shape = NA) + 
  theme_bw()

ggsave("cells_per_envGroup.png", width = 6, height = 4)

?facet_wrap
