#Make up some item response data
x <- c(0,1,2,0,1,2,0,1,2,3)
y <- c(2,1,2,3,2,1,2,2,1,2)
z <- c(1,2,3,1,3,0,1,0,0,1)
raw_resp <- rbind(x,y,z)

#pretend that items 5 and 10 are PCM, so the scores should stay the same as in raw data.
#use "p" to indicated the PCM items.
key <- c(1,1,2,3,"p",1,1,2,2,"p")
mcq <- which(key!="p")
scored <- sapply( seq(1,length(key)), FUN = 
  function(ii){if(ii %in% mcq){1*(raw_resp[,ii] == key[ii])}else {raw_resp[,ii]}}) 
scored

