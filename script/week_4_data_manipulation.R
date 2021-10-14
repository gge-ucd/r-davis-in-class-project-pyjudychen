#install.packages('dplyr')
library('tidyverse')
library('dplyr')

surveys = read_csv('data/portal_data_joined.csv') # use '_'instead of '.'
dim(surveys) # short for dimension 
colnames(surveys)

# Select
head(select(surveys, sex, weight, genus))

# Filter
head(filter(surveys, genus == 'Neotoma'))
head(filter(surveys, genus != 'Neotoma'))

# Pipe
surveys2 = filter(surveys, genus != 'Neotoma')
surveys3 = select(surveys2, sex, weight, genus)

surveys_filtered = select(filter(surveys, genus != 'Neotoma'), sex, weight, genus)
identical(surveys3, surveys_filtered)

## magrittr %>%
surveys_filtered_again = surveys %>%
  filter(genus != 'Neotoma') %>%
  select(sex, weight, genus)

identical(surveys_filtered, surveys_filtered_again)

# Mutate
surveys = surveys %>%
  mutate(weight_kg = weight / 1000) 

# Group by and summarize
surveys = read.csv('data/portal_data_joined.csv')
surveys %>%
  group_by(sex) %>%
  summarize(avg_weight = mean(weight, na.rm = TRUE), 
            med_weight = median(weight, na.rm = TRUE)) # remove NA values when calculate mean

# Tally
surveys %>%
  group_by(sex) %>%
  tally()

#1. keep only observation before 1995
surveys_base = filter(surveys, year < 1995)
#2. retain only the columns year, sex, and weight
surveys_challenge = select(surveys_base, year, sex, weight)
#2-1. keep only observation before 1995 and retain only the columns year, sex, and weight
surveys_challenge = surveys %>% 
  filter(year < 1995) %>%
  select(year, sex, weight)
  
# Create a new data frame from the surveys data that meets the following criteria: 
#1. contains only the species_id column 
#2. and a new column called hindfoot_half containing values that are half the hindfoot_length values. 
#3. In this hindfoot_half column, there are no NAs and all values are less than 30. 
#Name this data frame surveys_hindfoot_half
colnames(surveys)

surveys_hindfoot_half = surveys %>% 
  filter(!is.na(hindfoot_length)) %>%
  mutate(hindfoot_half = hindfoot_length/2) %>%
  select(species_id, hindfoot_half) %>%
  filter(hindfoot_half < 30)
str(surveys_hindfoot_half)

# Use group_by() and summarize() to find the mean, min, and max hindfoot length 
# for each species (using species_id).
surveys_hindfoot_summary= 
  surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(species_id) %>%
  summarize(mean_length = mean(hindfoot_length), 
            min_length = min(hindfoot_length), 
            max_length = max(hindfoot_length)) 
head(surveys_hindfoot_summary)
