#################################################################
#  generate item reponses using the Rasch model
#################################################################

set.seed(6778)
N <- 2000           # number of students
theta <- rnorm( N ) # student abilities
I <- 40             # number of items
p1 <- plogis( outer( theta , seq( -2 , 2 , len=I ) , "-" ) )  #item difficulties from -2 to 2
resp <- 1 * ( p1 > matrix( runif( N*I ) , nrow=N , ncol=I ) )  # item responses
colnames(resp) <- paste("I" , 1:I, sep="")

#################################################################
#  set missing completely at random
#################################################################

set.seed(3645)
N <- nrow(resp)
I <- ncol(resp)
resp2 <- as.matrix(resp)
missingrow <- round(runif(0.1*N*I)*N + 0.5)  #set 10% of missing data
missingcol <- round(runif(0.1*N*I)*I + 0.5)  
missing <- cbind(missingrow,missingcol)
resp2[missing] <- NA