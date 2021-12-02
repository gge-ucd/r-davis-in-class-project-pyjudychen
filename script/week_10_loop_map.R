# Iteration
iris[[1]] == iris$Sepal.Length

# For loops
for (i in 1:10){
  print(i)
}

for (i in 1:10){
  print(iris$Sepal.Length[i])
}

for (i in 1:10){
  print(iris$Sepal.Length[i])
  print(mtcars$mpg[i])
}

# Store output
results = rep(NA, nrow(mtcars))

for (i in 1:nrow(mtcars)){
  results[i] = mtcars$wt[i]*100
}

results

# Map family of function
library('tidyverse')
map(iris, mean)
map_df(iris, mean)
map_df(iris[1:4], mean)

# Mapping with 2 arguments with a pre-writen function
mtcars
print_mpg = function(x, y){
  paste(x, 'gets', y, 'miles per gallon')
}

map2_chr(rownames(mtcars), mtcars$mpg, print_mpg)

# Mapping with 2 arguments with an embedded "anonymous" function
map2_chr(rownames(mtcars), mtcars$mpg, function(x, y) paste(x, 'get', y, 'miles per gallon'))
