rm(list=ls())
#Use simulation to demonstrate the concept of standard error and central limit theorem.
#draw m samples, each sample has n observations, from a N(0,1)

n <- 100    #n is sample size
m <- 500  #m is the number of replications

sm <- replicate(m, {
  s <- rnorm(n)
  mean(s)
})
mean(sm)
sd(sm)
hist(sm)
qqnorm(sm)

#Draw from uniform distribution instead of normal
su <- replicate(m, {
  s <- runif(n)
  mean(s)
})
mean(su)
sd(su)
hist(su)
qqnorm(su)

#create a skewed population of size N
N <- 100000
x <- rnorm(N)
y <- x + 5*(1-exp(x)/(1+exp(x)))*runif(N)
y <- y - mean(y)
hist(y,xlim = c(-4,4))
mean(y)
median(y)
sd(y)

#draw m samples from y, each sample contains n observations
m <- 1000
n <- 100
w <- replicate(m, {
  s <- sample(y,n)
  mean(s)
})
mean(w)
sd(w)
hist(w)
qqnorm(w)
