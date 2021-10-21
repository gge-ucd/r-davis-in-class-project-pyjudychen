# 1. Load library and read file
library('tidyverse')
surveys = read.csv('../data/portal_data_joined.csv')
colnames(surveys)

# 2. Keep rows with weight between 30 and 60, and print out the first 6 rows
surveys_weight = surveys %>%
  filter(weight > 30 & weight < 60) %>%
  head()

# 3. Create a new tibble showing the maximum weight for each species 
# + sex combination and name it biggest_critters.

biggest_critters = surveys %>% 
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  summarize(max_wight = max(weight))

# 4.Figure out where the NA weights are concentrated in the data
na_dis_sp = surveys %>%
  filter(is.na(weight)) %>%
  group_by(species) %>%
  tally() %>%
  arrange(desc(n))
na_dis_plt = surveys %>%
  filter(is.na(weight)) %>%
  group_by(plot_id, plot_type) %>%
  tally() %>%
  arrange(desc(n))
na_dis_year = surveys %>%
  filter(is.na(weight)) %>%
  group_by(year) %>%
  tally() %>%
  arrange(desc(n))
# 4. Remove the rows where weight is NA and
# add a column that contains the average weight of each species
# +sex combination to the full surveys dataframe. 
# Then get rid of all the columns except for species, sex, weight
surveys_avg_weight = surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  mutate(avg_weight = mean(weight)) %>%
  select(species_id, sex, weight, avg_weight)
# 6. Add a new column called above_average that contains logical values 
# stating whether or not a row’s weight is above average for its species
#+sex combination
surveys_above_avg = surveys_avg_weight %>%
  mutate(above_avg = weight > avg_weight)