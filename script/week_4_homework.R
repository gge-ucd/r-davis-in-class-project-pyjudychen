library('tidyverse')
surveys = read.csv('data/portal_data_joined.csv')
colnames(surveys)

# keep rows with weight between 30 and 60, and print out the first 6 rows
surveys_weight = surveys %>%
  filter(weight > 30) %>%
  filter (weight < 60)
head(surveys_weight)

# Create a new tibble showing the maximum weight for each species 
# + sex combination and name it biggest_critters.

sp_max_weight = surveys %>% 
  filter(!is.na(weight)) %>%
  select(sex, species_id, weight) %>%
  group_by(species_id) %>%
  summarize(max_wight = max(weight))
