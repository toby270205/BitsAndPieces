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
