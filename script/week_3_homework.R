surveys = read.csv('data/portal_data_joined.csv')
colnames(surveys)
class(surveys)
surveys_base = data.frame(
  surveys$species_id, 
  surveys$weight, 
  surveys$plot_type)
 
# Have this data frame only be the first 60 rows
surveys_base = surveys_base[1:60, ]

# Convert both species_id and plot_type to factors.
surveys_base$surveys.species_id = as.factor(
  surveys_base$surveys.species_id)
surveys_base$surveys.plot_type = as.factor(
  surveys_base$surveys.plot_type)

# Remove all rows where there is an NA in the weight column.
surveys_base = na.omit(surveys_base)

# Create a second data frame (challenge_base) 
# that only consists of individuals from surveys_base with weights > 150g
challenge_base = subset(surveys_base, surveys_base$surveys.weight>150)
