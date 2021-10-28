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

# Challenge
# Use what you just learned to create a scatter plot of weight 
# and species_id with weight on the Y-axis, and species_id on the X-axis. 
# Have the colors be coded by plot_type. Is this a good way to show 
# this type of data? What might be a better graph?
ggplot(data = surveys_complete, mapping = aes(x=species_id, y=weight)) +
  geom_point(aes(color = plot_type))+
  facet_wrap(~plot_type)

# Challenge
# Make a new plot to explore the distrubtion of hindfoot_length just 
# for species NL and PF. Overlay a jitter plot of the hindfoot lengths 
# of each species by a boxplot. Then, color the datapoints according to 
# the plot from which the sample was taken.
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight))+
  scale_y_log10()+
  geom_violin()

species_nl_pf = filter(surveys_complete, species_id == 'NL'|species_id == 'PF')

ggplot(data = species_nl_pf, mapping = aes(x = species_id, y = hindfoot_length))+
  scale_y_log10()+
  geom_boxplot()

surveys_complete %>%
  # inclusive is & vs "or" |
  filter(species_id == "NL" | species_id == "PF") %>%
  mutate(plot_factor = as.factor(plot_id)) %>%
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_factor))

surveys_complete %>%
  # inclusive is & vs "or" |
  filter(species_id == "NL" | species_id == "PF") %>%
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = as.factor(plot_id)))
