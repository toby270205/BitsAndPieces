#Dummy Item Analysis R code
#Clean up variables in memory
rm(list=ls())

#Load libraries
library(CTT)
library(TAM)
library(WrightMap)
#library(xtable)

#Set working directory
setwd("C:\\G_MWU\\R Projects\\BitsAndPieces\\RMarkdown")

#Read in data file(s)
#(For multiple data files, see MergeMultipleDataSetsByColumnName.R)
#d <- read.csv("filename")  #csv files
#d <- read.fwf("filename",widths= c(-11,1,1,1,1,1,1,1,1,1,1,1,1,1)) #fixed width format; skip the first 11 columns
#d <- read.fortran("filename", c("i1","1x","A1","1x","91A1"))) #use Fortran format
B <- read.csv("B.csv")

#Make sure data have item names. If not, add column names
#colnames(B) <- paste("I",seq(1:ncol(B)),sep="")

#===================================================
#Data cleaning, recoding
#B[B==9] <- 0  #missing as wrong
B[B==9] <- NA #missing as missing
#Embedded missing to zero;trailing missing to missing, assuming all missing are coded NA in data
#Note that if there are missings by design, e.g., for rotated booklets, 
#then the missing-by-design responses must stay as missing.
TrailingNA <- function (x){
  ind <- sapply(seq(1,length(x)),function(i){all(is.na(tail(x,i)))})
  ind <- rev(ind) #indicates if the response is not-reached
  x[(is.na(x)) & (!ind)] <- 0 #if the NA response is omit (i.e., not not-reached), then set it to 0.
  x
}
BR <- t(apply(B,1,TrailingNA))

#Make sure records containing all NAs are removed
all.na <- apply(BR, 1, function(x){all(is.na(x))})  
BR <- BR[!all.na,]   #Delete records with all missing responses

#Identify deleted records, and put these in the report appendix.
AllNA <- which(all.na)

#Manually recode some data if necessary
#recode <- function(x) {x <- x-1}
#recoderev4 <- function(x) {x <- 4-x}

#BR[,c(24,26,34)] <- recoderev4(BR[,c(24,26,34)]) #reverse score of negatively worded questions
#BR[,c(19:23,25,27:33,35:38)] <- recode(BR[,c(19:23,25,27:33,35:38)] )

#===================================================
#Score data with key. "p" denotes partial credit items without key.  BR is the raw item response data.
key <- unlist(strsplit("242342334pp43pppppp32112pp3pp234121331112pppppppppp3pppp",split=""))
mcq <- which(key!="p")
scored <- sapply( seq(1,length(key)), 
        FUN = function(ii){if(ii %in% mcq ){1*(BR[,ii] == key[ii])}else {BR[,ii]}}) 
colnames(scored) <- colnames(BR)
#Alternatively, score data manually:
#scored <- BR
#scored[,c(22,23,33,35,38,39,40)] <- (BR[,c(22,23,33,35,38,39,40)]==1)*1  #Answer A 
#scored[,c(1,3,6,21,24,30,34,41)] <- (BR[,c(1,3,6,21,24,30,34,41)]==2)*1  #Answer B 
#scored[,c(4,7,8,13,20,27,31,36,37,52)] <- (BR[,c(4,7,8,13,20,27,31,36,37,52)]==3)*1  #Answer C 
#scored[,c(2,5,9,12,32)] <- (BR[,c(2,5,9,12,32)]==4)*1  #Answer D 

#Ensure that NA stays as NA after scoring

#===================================================
#Rename variables where resp refers to scored and resp_raw refers to unscored item response data.
resp <- scored
resp_raw <- BR

#===================================================
#Classical test item analysis using package CTT
#CTT package will not be suitable for rotated test booklets where there are NAs by design
CTTstats <- CTT::reliability(resp, NA.Delete = TRUE) #Listwise deletion if there are NAs
              #Be careful if NA.Delete is FALSE. All NAs will be changed to 0. 
              #This will not be appropriate if NAs are by design.
alpha <- CTTstats$alpha
pBis <- CTTstats$pBis   
itemdiff0 <- CTTstats$itemMean  

#CTT analysis using R commands
itemdiff <- apply(resp,2,function(x){sum(x,na.rm=TRUE)/(max(x,na.rm=TRUE)*length(x[!is.na(x)]))}) #NAs are skipped.
#The above takes care of partial credit items where the max score is more than 1.
#If items are all dichotomous, then use "apply(resp,2,mean,na.rm=TRUE)"

score <- apply(resp,1,sum,na.rm=TRUE) #Note here NA are skipped.
#Alternative person score, treating NA as 0.
#Be very careful about this, as sometimes NAs are by design, as in rotated booklets
#So we can't change NAs to 0.
#resp0 <- resp
#resp0[is.na(resp)] <- 0
#score <- apply(resp0,1,sum)  #Here NAs are treated as 0.

#disc(pBis) using R command
disc <- apply(resp,2,function(x){cor(x,score-x,use="complete.obs")})  #Here NAs are changed to 0.

#===================================================
#IRT analysis using package TAM
mod1 <- tam(resp)

#Ability estimate - Weighted Likelihood Estimate
Abil <- tam.wle(mod1)
Ability <- Abil$theta

#Item thresholds
thr <- tam.threshold(mod1)

#WrightMap

p <- wrightMap(Ability, thr,item.side = itemClassic)

#===================================================
#Use the tam.ctt function for distractor analysis
#===================================================
ctt_raw <- tam.ctt(resp_raw,Ability)
ctt_raw <- cbind(ctt_raw[,4:7],round(ctt_raw[,8:10],2))

colnames(ctt_raw) <- c("Item", "Total", "Category", "Count", "Percent", "Pbs", "MeanAbility")
cname <- c("miss","A", "B", "C", "D", "E")

#===================================================
#Residual-based fit statistics
#===================================================
mod0 <- tam.jml(resp)
fit0 <- msq.itemfit(mod1)$itemfit
fit <- cbind(fit0[,1],round(fit0[3:8],2))
colnames(fit) <- c("item",colnames(fit[,2:7]))

lower <- 1-2*sqrt(2/nrow(resp))
if (lower<0) lower=0
upper <- 1+2*sqrt(2/nrow(resp))

#Render Rmarkdown report
rmarkdown::render("DummyItemAnalysis.Rmd") 
#rmarkdown::render("DummyItemAnalysis.Rmd",encoding="utf8") #utf8 is for Chinese fonts

