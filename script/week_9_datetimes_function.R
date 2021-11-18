# Dates
sample_dates_1 = c('2018-02-01', '2018-03-21', '2018-10-05', '2019-01-01', '2019-02-18')
sample_dates_1 = as.Date(sample_dates_1)
str(sample_dates_1) #changes from character to date

sample_dates_2 = c('02-01-2018', '03-21-2018', '10-05-2018', '01-01-2019', '02-28-2019')
sample_dates_3 = as.Date(sample_dates_2, format = '%m-%d-%Y')

as.Date('2016/01/01', format = '%Y/%m/%d')
as.Date('05A21A2011', format = '%mA%dA%Y')

as.Date('Jul 04, 2019', format = '%b %d, %Y')
tm2 = as.POSIXct('25072016 08:32:07', format = '%d%m%Y %H:%M:%S')
tm2

# The lubridate package 
#install.packages('lubridate')
library('lubridate')
sample_dates_lub = ymd(sample_dates_1)
lubridate::ymd('2016/01/01')
lubridate::ymd('2011-03-19')
lubridate::mdy('Feb 19, 2011')
lubridate::dmy('22051997')


#--- Function writing----
# A summing function with no built-in arguments
my_sum = function(number1, number2){
  the_sum = number1 + number2
  return(the_sum)
}

my_sum(10, 5)

# A summing function but with default values for arguments
my_sum2 = function(number1 = 5, number2 = 10){
  the_sum = number1+number2
  return(the_sum)
}
my_sum2()

# Temperature conversion
F_to_K = function(tempF){
  K = ((tempF-32)*(5/9))+273.15
  return(K)
}

F_to_K(32)

# Gapmind data set: Average GDP per capita over a range of years
library(tidyverse)
#install.packages('gapminder')
library('gapminder')
summary(gapminder)
gapminder %>% 
  filter(country == 'Canada', year %in% 1970:1980) %>%
  summarize(mean(gdpPercap, na.rm = TRUE))

avgGDP = function(cntry, yr.range){
  gapminder %>% 
    filter(country == cntry, year %in% yr.range) %>% 
    summarize(mean(gdpPercap), na.rm = TRUE)
}

avgGDP(cntry = 'Iran', yr.range = 1985:1990)    
avgGDP(cntry = 'Taiwan', yr.range = 1900:2000)
