x <- c(3,1,4,NA,5,6,3,NA,NA,NA)
ind <- sapply(seq(1,length(x)),function(i){all(is.na(tail(x,i)))})
ind <- rev(ind) #indicates if the response is not-reached
x[(is.na(x)) & (!ind)] <- 0 #if the NA response is omit (i.e., not not-reached), then set it to 0.

#If all omits are already zero (or 9), then change all zeros to NA, and apply the above.
x <- c(3,1,4,0,5,6,3,0,0,0)
x[x==0] <- NA
