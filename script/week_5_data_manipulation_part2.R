library(tidyverse)
# Conditional Statements
surveys = read_csv('data/portal_data_joined.csv')

summary(surveys$hindfoot_length)
ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = TRUE),
       'small', 'big')
surveys = mutate(surveys, hindfoot_size = 
                   ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = TRUE),
                          'small', 'big'))
surveys$hindfoot_size

# Joining two dataframes
tail = read_csv('data/tail_length.csv')
str(tail)
summary(tail$record_id)
summary(surveys$record_id)
surveys_joined = left_join(surveys, tail, by = 'record_id')
str(surveys_joined)

# Reshaping with pivot functions
## pivot_wider
surveys_mz = surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus, plot_id) %>%
  summarize(mean_weight = mean(weight))
unique(surveys_mz$genus)
n_distinct(surveys_mz$genus)

wide_surveys = surveys_mz %>% 
              pivot_wider(names_from = 'plot_id', values_from = 'mean_weight')
dim(wide_surveys)
str(wide_surveys)
head(wide_surveys)

## pivot_longer
long_surveys = wide_surveys %>%
  pivot_longer(col = -genus, names_to = 'plot_id', values_to = 'mean_weight')
View(long_survey) # NA is included

long_surveys = long_surveys %>%
  filter(!is.na(mean_weight))
  