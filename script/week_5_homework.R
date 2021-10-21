library(tidyverse)
surveys = read_csv('data/portal_data_joined.csv')

#1. manipulate surveys to create a new dataframe called surveys_wide 
#with a column for genus and a column named after every plot type,
#with each of these columns containing the mean hindfoot length of animals 
#in that plot type and genus.
colnames(surveys)
surveys_wide = surveys %>% 
  filter (!is.na(hindfoot_length)) %>%
  group_by(genus, plot_type) %>%
  summarize(mean_hindfoot = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = 'plot_type', values_from = 'mean_hindfoot')

#2. calculate a new weight category variable called weight_cat. 
#For this variable, define the rodent weight into three categories, 
#where “small” is less than or equal to the 1st quartile of weight distribution, 
#“medium” is between (but not inclusive) the 1st and 3rd quartile, and 
#“large” is any weight greater than or equal to the 3rd quartile. 
surveys = surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_cat = 
  case_when(
    weight < summary(weight)[2] ~ 'small',
    weight > summary(weight)[2] & weight < summary(weight)[5] ~'medium', 
    weight > summary(weight)[5] ~'large'
    ))
