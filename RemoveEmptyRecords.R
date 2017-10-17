#Remove records with missing responses for all items
#resp contains a matrix of item responses
#Find records where all responses are missing.
all.na <- apply(resp, 1, function(x){all(is.na(x))})  
resp <- resp[!all.na,]   #Delete records with all missing responses
