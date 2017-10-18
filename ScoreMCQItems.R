#rawdata contains the unscored item responses.
#resp contained the scored item responses

key <- c(3,1,3,1,2,1,3,2,2,3,3,2,6)
resp <- sapply( seq(1,length(key)), 
                FUN = function(ii){ 1*(rawdata[,ii] == key[ii]) } )

#Alternatively, use the function "score" in CTT package for scoring.