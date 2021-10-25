library('tidyverse')
#install.packages('ggthemes')
library('ggthemes')

surveys_complete = read_csv('data/portal_data_joined.csv') %>% 
  filter(complete.cases(.)) # remove all NA

# Plotting with ggplot2
ggplot(data = surveys_complete) 
ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length)) +
    geom_point()
base_plot = ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length))
base_plot+geom_point()

# Building your plots iteratively
base_plot+geom_point(alpha = 0.1)
base_plot+geom_point(color = 'navy', alpha = 0.2)

base_plot+geom_point(alpha = 0.1, aes(color = species_id))

# Boxplot
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight))+
    geom_boxplot()
base_plot2 = ggplot(data = surveys_complete, mapping = aes(x = species, y = weight))

base_plot2 + 
  geom_boxplot(color = 'purple')+
  geom_jitter(alpha = 0.3, color = 'tomato')

base_plot2 + 
  geom_boxplot(color = 'purple')+
  geom_jitter(alpha = 0.1, mapping = aes(color = species_id))

# Plotting time series data
yearly_counts = surveys_complete %>% 
  count(year, species_id)
ggplot(data = yearly_counts, mapping = aes(x = year, y = n))+
  geom_line()
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id))+
  geom_line()

base_plot3 = ggplot(data = yearly_counts, mapping = aes(x = year, y = n))

base_plot3+
  geom_line()+
  facet_wrap(~ species_id, scales = 'free_y')

# Costum plot
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id))+
  geom_line()+
  theme_economist()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id))+
  geom_line()+
  theme_map()
