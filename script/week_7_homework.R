library(tidyverse)
gapminder = read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

gapminder_2002_2007 = gapminder %>% 
  filter(year %in% c(2002, 2007)) %>% 
  pivot_wider(id_cols = c(country, continent), names_from = year, values_from = pop) %>% 
  mutate(popDiff = `2007` - `2002`) %>% 
  filter(continent != 'Oceania')

ggplot(gapminder_2002_2007)+
  facet_wrap(~continent, scale = 'free')+
  geom_bar(aes(x = reorder(country, popDiff), y = popDiff), stat = 'identity')+
  geom_col(aes(x = reorder(country, popDiff), y = popDiff, fill = continent))+
  labs(x = 'Country', y = 'Change in Population between 2002 and 2007')+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, size = 2))+
  theme(legend.position='none')

