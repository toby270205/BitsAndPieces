#Simple recodings

#Make up some item response data
x <- c(0,1,2,NA,1,2,0,1,2,3)
y <- c(2,1,2,3,2,1,2,2,1,2)
z <- c(1,2,3,1,3,0,1,0,NA,1)
A <- rbind(x,y,z)

#recode zero to missing
A[A==0] <- NA

#recode missing to zero
A[is.na(A)] <- 0

#Reverse code Q8,9,10. E.g., for negatively worded questions in questionnaires
#E.g., 0,1,2,3 are changed to 3,2,1,0
A[,c(8,9,10)] <- 3 - A[,c(8,9,10)] 

#recode from zero. E.g., in questionnaire,the lowest category is 1, not zero. 
B <- B - 1
#or, just for items 2 and 10
A[,c(2,10)] <- A[,c(2,10)] - 1

#recode string variable to numeric variable
resp$cnt[resp$CNT=="DEU"] <- 1
resp$cnt[resp$CNT=="TAP"] <- 2



