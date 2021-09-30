# Create a vector
number_vector[c(2,2)]
number_vector[c(3,2,1)]

number_vector = c(23, 32, 45)
number_vector = c(number_vector,54)
number_vector

# Create a string
str1 = 'Hello'
?str()

# Create a data frame
?data.frame()
my_string = c('dog', 'walrus', 'salmon')
data.frame(my_string)
df1 = data.frame(first_column = my_string)
test_list[[1]][2] <- 'add next thing'

# Create a list
test_list = list('first string entry into list', 'Second string')
test_list = c(test_list, 2)

df_test = data.frame(letters, letters)
test_list = c(test_list, df_test)
test_list[[3]] = df_test

str(test_list)
test_list[[2]]
test_list[[3]]
