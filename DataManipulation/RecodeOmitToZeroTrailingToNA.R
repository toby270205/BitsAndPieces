#The following code will change NA's in a vector, x.
x <- c(3,1,4,NA,5,6,3,NA,NA,NA)
ind <- sapply(seq(1,length(x)),function(i){all(is.na(tail(x,i)))})
ind <- rev(ind) #indicates if the response is not-reached
x[(is.na(x)) & (!ind)] <- 0 #if the NA response is omit (i.e., not not-reached), then set it to 0.

#If all omits have other codes (e.g., 9), then change all omits to NA, and apply the above.
x <- c(3,1,4,9,5,6,3,9,9,9)
x[x==9] <- NA

#If B is a matrix of item responses where all missings are coded as NA,
#then define function TarilingNA as follows:
B[B==9]  <- NA  #ensure all missings are coded as NA
TrailingNA <- function (x){
  ind <- sapply(seq(1,length(x)),function(i){all(is.na(tail(x,i)))})
  ind <- rev(ind) #indicates if the response is not-reached
  x[(is.na(x)) & (!ind)] <- 0 #if the NA response is omit (i.e., not not-reached), then set it to 0.
  x
}
B1 <- t(apply(B,1,TrailingNA))
