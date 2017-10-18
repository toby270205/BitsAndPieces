#Randomly sample rows of item response data

n <- 200  #size of sample to be selected
A2 <- A[sample(nrow(A),n),]