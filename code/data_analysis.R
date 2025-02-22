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
taxon_dirty <- read_csv("data/taxon_abundance.csv", skip = 2)
head(taxon_dirty)

# Only pick to the cyanobacteria 
taxon_clean <- 
  taxon_dirty %>%
  select(sample_id:Cyanobacteria)
# What are the wide format dimension? 71 rows by 7 columns 
dim(taxon_clean)  

# Pivot_Longer: Shape the data from wide into long format 
taxon_long <- 
  taxon_clean %>%
  # shape into long-formatted data frame
  pivot_longer(cols = Proteobacteria:Cyanobacteria,
               names_to = "Phylum",
               values_to = "Abundance")
# Check the new dimensions: 426 rows by 3 columns 
dim(taxon_long)

# Calculate avg abundance of each phylum 
taxon_long %>%
  group_by(Phylum) %>%
  summarize(avg_abund = mean(Abundance))

# Plot our data 
taxon_long %>%
  ggplot(aes(x = sample_id, y = Abundance, fill = Phylum)) + 
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90))


# Joining data frames 
sample_data %>%
  head(6)

taxon_clean %>%
  head(6)

# inner join
sample_data %>%
  inner_join(., taxon_clean, by = "sample_id")

# Intuition check on filtering joins 
length(unique(taxon_clean$sample_id))
length(unique(sample_data$sample_id))

# Anti-join: which rows are not joining? 
sample_data %>%
  anti_join(., taxon_clean, by = "sample_id")

# Fixing September samples 
taxon_clean_goodSept <- 
  taxon_clean %>% 
  # Replace sample_id column with fixed september names 
  mutate(sample_id = str_replace(sample_id, 
                                 pattern = "Sep", replacement = "September"))

# check dimensions 
dim(taxon_clean_goodSept)

# Inner join 
sample_and_taxon <- 
  sample_data %>%
  inner_join(., taxon_clean_goodSept, by = "sample_id")

# Intuition check 
dim(sample_and_taxon)

# test 
stopifnot(nrow(sample_and_taxon) == nrow(sample_data))

# Write out our clean data into a new file 
write_csv(sample_and_taxon, "data/sample_and_taxon.csv")

# Quick Plot of Chloroflexi 
sample_and_taxon %>%
  ggplot(aes(x = depth, y = Chloroflexi)) + 
  geom_point() + 
  # add a statistical model
  geom_smooth()

