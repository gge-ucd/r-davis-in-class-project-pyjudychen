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
surveys = surveys %>%
  filter(!is.na(weight)) %>% 
  mutate(weight_cat = case_when(weight > mean(weight) ~ 'big',
                                weight < mean(weight) ~ 'small'))
colnames(surveys)
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

# Challenge (conditional statement)
summary(iris)
iris = iris %>% 
  mutate(iris, pd_len_cat = 
  case_when(
            Petal.Length <= summary(Petal.Length)[2] ~ 'small', 
            Petal.Length > summary(Petal.Length)[2] & Petal.Length <= summary(Petal.Length)[5] ~ 'medium', 
            Petal.Length > summary(Petal.Length)[5] ~ 'large'
            ))
head(iris)

# Challenge (Reshaping with pivot functions)
surveys_plt_id_year = surveys %>% 
  group_by(plot_id, year) %>% 
  summarize(n_genera = n_distinct(genus)) %>% 
  pivot_wider(names_from = 'year', values_from = 'n_genera')

#Another way to solve challenge
temp_df = surveys %>% group_by(year,plot_id) %>% tally()
temp_df = temp_df %>% ungroup()

pivot_wider(temp_df)
pivot_wider(temp_df,names_from = 'year',values_from = 'n')

pivot_wider(data = surveys,id_cols = c('plot_id'),
            names_from = year,values_fn = n)
pivot_wider(temp_df,id_cols = 'plot_id',names_from = 'year',values_from = 'n')