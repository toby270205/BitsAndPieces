#Merge two data sets by common column names. E.g., rotated test booklets

#Create two dummy data sets, x and y
x <- cbind(c(6,6,6,6),c(7,7,7,7),c(8,8,8,8),c(9,9,9,9),c(10,10,10,10))
colnames(x) <- c("x1","x2","x3","aa","x5")

y <- cbind(c(1,2,3,4,5),c(3,4,2,1,4),c(6,7,8,5,9))
colnames(y) <- c("y1","aa","y3")

x <- data.frame(x)  #x and y need to be data frames before they can be merged
y <- data.frame(y)

#Use the rbind.fill function from package "plyr" to merge x and y
library(plyr)
z <- rbind.fill(x,y)