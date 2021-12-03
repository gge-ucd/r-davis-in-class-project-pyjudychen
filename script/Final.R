<<<<<<< HEAD
# Load library
library(dplyr)
library(ggplot2)
library(lubridate)

# Load data
flights = read.csv('https://raw.githubusercontent.com/gge-ucd/r-davis-in-class-project-pyjudychen/master/data/nyc_13_flights_small.csv')
planes = read.csv('https://raw.githubusercontent.com/gge-ucd/r-davis-in-class-project-pyjudychen/master/data/nyc_13_planes.csv')
weather = read.csv('https://raw.githubusercontent.com/gge-ucd/r-davis-in-class-project-pyjudychen/master/data/nyc_13_weather.csv')

colnames(flights)
colnames(planes)
colnames(weather)

fl_w_joined = left_join(flights, weather)
flight_joined = left_join(fl_w_joined, planes)

# 1. Plot the departure delay of flights against the precipitation, 
# and include a simple regression line as part of the plot. 
# Hint: there is a geom_ that will plot a simple y ~ x regression line for you, 
# but you might have to use an argument to make sure it's a regular linear model. 
# Use ggsave to save your ggplot objects into a new folder you create called "plots".

summary(flight_joined$dep_delay)
summary(flight_joined$precip)

flight_joined = flight_joined %>%
  filter(!is.na(dep_delay)) %>% 
  filter(!is.na(precip))

plot1 = ggplot(flight_joined, aes(x = dep_delay, y = precip))+
  geom_point()+
  geom_smooth(method = "lm", se = TRUE)+
  theme_classic()

ggsave("C:/Users/user/Desktop/R_DAVIS_2021/r-davis-in-class-project-pyjudychen/script/plot/Relationship of delay and precip.png", plot1, width = 6, height = 4, units = "in", dpi = 300)
# 2. Create a figure that has date on the x axis and each day's mean departure delay on 
# the y axis. Plot only months September through December. 
# Somehow distinguish between airline carriers (the method is up to you). 
# Again, save your final product into the "plot" folder.
summary(flight_joined$day)
summary(flight_joined$dep_delay)
colnames(flight_joined)
colnames(flight_joined_sep_dec)

flight_joined_sep_dec = flight_joined %>% 
  filter(month > 8) %>%
  mutate(date = ymd(paste(year, month, day, sep = '-'))) %>% 
  group_by(date, dep_delay) %>% 
  mutate(mean_dely = mean(dep_delay))
  
plot2 = ggplot(flight_joined_sep_dec, aes(x = date, y = mean_dely))+
  geom_point(aes(col = carrier))+
  scale_color_viridis_d()+
  theme_classic()

ggsave("C:/Users/user/Desktop/R_DAVIS_2021/r-davis-in-class-project-pyjudychen/script/plot/mean_dely_date.png", plot2, width = 6, height = 4, units = "in", dpi = 300)

# 3. Create a dataframe with these columns: date (year, month and day), 
# mean_temp, where each row represents the airport, based on airport code (origin). 
# Save this is a new csv into you data folder called mean_temp_by_origin.csv
new_df = data.frame(flight_joined$origin, flight_joined$year, flight_joined$month, flight_joined$day)
write.csv(new_df, 'C:/Users/user/Desktop/R_DAVIS_2021/r-davis-in-class-project-pyjudychen/data/mean_temp_by_origin.csv')

# Load library
library(dplyr)
library(ggplot2)
library(lubridate)

# Load data
flights = read.csv('https://raw.githubusercontent.com/gge-ucd/r-davis-in-class-project-pyjudychen/master/data/nyc_13_flights_small.csv')
planes = read.csv('https://raw.githubusercontent.com/gge-ucd/r-davis-in-class-project-pyjudychen/master/data/nyc_13_planes.csv')
weather = read.csv('https://raw.githubusercontent.com/gge-ucd/r-davis-in-class-project-pyjudychen/master/data/nyc_13_weather.csv')

colnames(flights)
colnames(planes)
colnames(weather)

fl_w_joined = left_join(flights, weather)
flight_joined = left_join(fl_w_joined, planes)

# 1. Plot the departure delay of flights against the precipitation, 
# and include a simple regression line as part of the plot. 
# Hint: there is a geom_ that will plot a simple y ~ x regression line for you, 
# but you might have to use an argument to make sure it's a regular linear model. 
# Use ggsave to save your ggplot objects into a new folder you create called "plots".

summary(flight_joined$dep_delay)
summary(flight_joined$precip)

flight_joined = flight_joined %>%
  filter(!is.na(dep_delay)) %>% 
  filter(!is.na(precip))

plot1 = ggplot(flight_joined, aes(x = dep_delay, y = precip))+
  geom_point()+
  geom_smooth(method = "lm", se = TRUE)+
  theme_classic()

ggsave("C:/Users/user/Desktop/R_DAVIS_2021/r-davis-in-class-project-pyjudychen/script/plot/Relationship of delay and precip.png", plot1, width = 6, height = 4, units = "in", dpi = 300)
# 2. Create a figure that has date on the x axis and each day's mean departure delay on 
# the y axis. Plot only months September through December. 
# Somehow distinguish between airline carriers (the method is up to you). 
# Again, save your final product into the "plot" folder.
summary(flight_joined$day)
summary(flight_joined$dep_delay)
colnames(flight_joined)
colnames(flight_joined_sep_dec)

flight_joined_sep_dec = flight_joined %>% 
  filter(month > 8) %>%
  mutate(date = ymd(paste(year, month, day, sep = '-'))) %>% 
  group_by(date, dep_delay) %>% 
  mutate(mean_dely = mean(dep_delay))
  
plot2 = ggplot(flight_joined_sep_dec, aes(x = date, y = mean_dely))+
  geom_point(aes(col = carrier))+
  scale_color_viridis_d()+
  theme_classic()

ggsave("C:/Users/user/Desktop/R_DAVIS_2021/r-davis-in-class-project-pyjudychen/script/plot/mean_dely_date.png", plot2, width = 6, height = 4, units = "in", dpi = 300)

# 3. Create a dataframe with these columns: date (year, month and day), 
# mean_temp, where each row represents the airport, based on airport code (origin). 
# Save this is a new csv into you data folder called mean_temp_by_origin.csv
new_df = data.frame(flight_joined$origin, flight_joined$year, flight_joined$month, flight_joined$day)
write.csv(new_df, 'C:/Users/user/Desktop/R_DAVIS_2021/r-davis-in-class-project-pyjudychen/data/ean_temp_by_origin.csv')

# 4. Make a function that can: (1) convert hours to minutes; and 
#(2) convert minutes to hours (i.e., it’s going to require some sort of 
#conditional setting in the function that determines which direction the 
#conversion is going). Use this function to convert departure delay 
#(currently in minutes) to hours and then generate a boxplot of departure delay times by carrier. 
#Save this function into a script called “customFunctions.R” in your scripts/code folder.
