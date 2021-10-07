set.seed(15) # Random Number Generation
hw2 <- runif(50, 4, 50) # Generate 50 numbers ranges from 4 to 50
hw2 <- replace(hw2, c(4,12,22,27), NA) # replace numbers with NA

hw2 = hw2[!is.na(hw2)] # Get values from hw2 that is not NA
prob1 = subset(hw2, 14 <= hw2 & hw2 <= 38)
# other solution
# prob1_0 = prob1[14 <= prob1 & prob1 <= 38]

times3 = prob1*3
plus10 = times3 + 10
final = plus10[seq(1,length(plus10),2)]