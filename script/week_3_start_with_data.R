surveys = read.csv('data/portal_data_joined.csv')
nrow(surveys)
ncol(surveys)

class(surveys) # data.frame
head(surveys) # look at top 6 rows of data
tail(surveys) # look at bottom 6 rows of data
View(surveys) # open data in another tab
str(surveys) # view the structure of data
summary(surveys)

## Index (row first, then column)
surveys[1, 1] # first row, first column
surveys[1, ] # first row
surveys[, 6] # sixth column (output: vector)
surveys[6] # maintain data.frame structure
class(surveys[, 6]) 
class(surveys[6])

surveys[1:6, ] # show first six rows
surveys[-(1:6), ] # skip first six rows
surveys[-1, ] # skip the first row

colnames(surveys)
surveys['species_id'] # maintain data.frame structure
surveys[, 'species_id'] # output: vector
class(surveys['species_id'])
class(surveys[, 'species_id'])

surveys$species_id # output: vector (preferalbe option)

## tidyverse
# install.packages('tidyverse')
library(tidyverse) # fancier data.frame
surveys_t = read_csv('data/portal_data_joined.csv')
View(surveys_t)
class(surveys_t) # table
class(surveys) # data.frame

surveys[, 1]
surveys_t[, 1]
