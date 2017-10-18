rm(list = ls())  #remove all variables in memory
library(TAM)
setwd("C:\\G_MWU\\TAM\\ItemSeparationTest")

#simulate PCM data
set.seed(37265)

I <- 20   #no. of items
N <- 5000 #no. of persons
K <- 6    #no. of response categories for each item

#PCM deltas
#delta.dot <- seq(-2,2,length=I)  #different delta.dots across items
delta.dot <- rep(0,I)             #same delta.dots for all items
tau <- c(-2,-1,0,1,2)
deltas <- outer(delta.dot,tau,"+") #need to create a matrix of PCM deltas
thetas <- rnorm(N)

probs <- function(thetan,delta){
  K1 <- length(delta)
  cdelta <- cumsum(delta)
  ctheta <- sapply(1:K1,function(x){x*thetan})
  num <- exp(ctheta-cdelta)
  den <- 1+sum(num)
  prob <- c(1,num)/den
  return (prob)
}
genresp <- function(prob){
  cprob <- cumsum(prob)
  r <- findInterval(runif(1),cprob)
  return (r)
}

PCMresp <- function(person,item,deltas,thetas,a){
#  p <- probs(theta,deltas[item,])
#  r <- genresp(p)
  delta <- deltas[item,]
  theta <- thetas[person]
  K1 <- length(delta)
  cdelta <- cumsum(delta)
  ctheta <- sapply(1:K1,function(x){x*theta})
  num <- exp(a*(ctheta-cdelta))
  den <- 1+sum(num)
  prob <- c(1,num)/den
  cprob <- cumsum(prob)
  r <- findInterval(runif(1),cprob)  
  return (r)
}

#call PCMresp function to generate PCM item responses
resp <- matrix(0,nrow=N,ncol=I)
for (n in 1:N){
  for (i in 1:I){
    resp[n,i] <- PCMresp(n,i,deltas,thetas,1)
  }
}

mod1 <- tam(resp)


