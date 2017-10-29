#Read in data files
setwd("C:\\G_MWU\\R Projects\\BitsAndPieces\\DataManipulation")

#Data files are named "tblBook01.csv", "tblBook02.csv", etc.
for (n in 1:4){
  if(n < 10) bookname <- paste("tblBook","0",sep="")
  bookname <- paste(bookname,n,".csv",sep="")
  assign(paste("B",n,sep=""),read.csv(bookname)  )  #dynamically create variable names
}
D <- Reduce(function(x, y) merge(x, y, all=TRUE), list(B1,B2,B3,B4)) #combine data frames
#Note that the rbind.fill function from package plyr works better than the merge function

D <- D[,order(names(D))] 

M <- subset(D, select = c(PS01:PS25))
