#Merge two data sets by row ID. E.g., find gender from data set 1, 
#  and put gender in data set 2 according to row ID.

x <- seq(1,10)
y <- rnorm(10)
data1 <- cbind(x,y)
data1 <- rbind(data1,data1)
data1 <- data1[order(data1[,1]),]
data1unique <- unique(data1)

data2 <- cbind(data1[,1],rnorm(20))

data3 <- data1unique[data2[,1],2]

data4 <- cbind(data2,data3)
