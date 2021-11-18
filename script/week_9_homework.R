library(tidyverse)
library(lubridate)
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
colnames(mloa)

# 1. Remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s. 
mloa_sub = mloa %>%  filter(rel_humid != -99, temp_C_2m != -999.9, windSpeed_m_s != -99.9)

# 2. Generate a column called "datetime" using the year, month, day, hour24, and min columns.
# this version pastes year month day together by row and hten calls ymd
mloa_sub %>% mutate(datetime = paste(year,month,day,sep = '-')) %>%
  mutate(datetime = ymd(datetime)) %>% select(datetime)
colnames(mloa_sub)

#this version does both actions at once in the same mutate call
mloa_sub %>% mutate(datetime = ymd(paste(year, month, day, sep = '-'))) %>% select(datetime)


# add in hour24
mloa_sub %>% mutate(datetime = ymd_h(paste(year, month, day, hour24, sep = '-'))) %>% select(datetime)

# add in min
mloa_sub %>% mutate(datetime = ymd_hm(paste(year, month, day, hour24, min, sep = '-'))) %>% select(datetime)

#now let's add in min, and we are done with this task
mloa_sub = mloa_sub %>% mutate(datetime = ymd_hm(paste(year,month,day,hour24,min,sep = '-')))

#Next, create a column called "datetimeLocal" that converts the datetime column
#to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()).

mloa_sub$datetimeLocal = with_tz(time = mloa_sub$datetime,tzone = 'Pacific/Honolulu')
colnames(mloa_sub)

mloa_sub = mloa_sub %>% mutate(localmonth = month(datetimeLocal), localhour = hour(datetimeLocal)) %>% 
  group_by(localmonth, localhour) %>% 
  summarize(meantemp = mean(temp_C_2m))

ggplot(mloa_sub, aes(x = localmonth, y = meantemp))+
  geom_point(aes(col = mloa_sub$localhour))+
  scale_color_viridis_c()+
  xlab('Month')+
  ylab('Mean temperature (degrees C)')+
  theme_classic()
