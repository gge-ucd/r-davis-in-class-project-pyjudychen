library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary

# 1. Calculates mean life expectancy on each continent. 
# Then create a plot that shows how life expectancy has changed 
# over time in each continent. Try to do this all in one step using 
# pipes! (aka, try not to create intermediate dataframes)
gapminder_avg_lifeExp = gapminder %>% 
  filter(!is.na(lifeExp)) %>% 
  group_by(country) %>% 
  summarize(avg_lifeExp = mean(lifeExp))
  
ggplot(data = gapminder_avg_lifeExp, mapping = aes(x=gapminder$year, y=avg_lifeExp, group_by(continent)))+
  geom_point(aes(color = gapminder$continent))

# 2. Look at the following code and answer the following questions. 
# What do you think the scale_x_log10() line of code is achieving? 
# What about the geom_smooth() line of code?

# Challenge! Modify the above code to size the points in proportion to 
# the population of the country. Hint: Are you translating data to 
# a visual feature of the plot?
ggplot(data = gapminder, mapping = aes(x=gdpPercap, y=lifeExp, size = pop)) + 
  geom_point(alpha = 0.2, aes(color = continent)) + 
  scale_x_log10()+
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# 3. Create a boxplot that shows the life expectency 
# for Brazil, China, El Salvador, Niger, and the United States, 
# with the data points in the backgroud using geom_jitter. 
# Label the X and Y axis with “Country” and “Life Expectancy” and 
# title the plot “Life Expectancy of Five Countries”.

gapminder_countries = 
  filter(gapminder, country == 'Brazil'|country == 'China'|country == 'El Salvador'|country == 'Niger'|country =='United States')
ggplot(data = gapminder_countries, mapping = aes(x=country, y=lifeExp, group = country))+
  geom_boxplot()+
  scale_x_discrete(name ="Country")+
  scale_y_continuous(name="Life Expectancy", limits=c(40, 80))+
  labs(title="Life Expectancy of Five Countries")+
  geom_jitter(alpha = 1)
