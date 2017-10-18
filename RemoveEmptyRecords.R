#Simulate some data
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
#Make records 10 and 15 as all missing
resp[c(10,15),] <- NA

#Remove records with missing responses for all items
#resp contains a matrix of item responses
#Find records where all responses are missing.
all.na <- apply(resp, 1, function(x){all(is.na(x))})  
resp <- resp[!all.na,]   #Delete records with all missing responses

#Record numbers of deleted records, and perhaps put this in the report appendix.
which(all.na)
