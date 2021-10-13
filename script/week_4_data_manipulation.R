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
