#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: try.R
# Desc: try function exercise, random sampling from the population
# Arguments: 0
# Input:Rscript try.R
# Output: printed output in r terminal
# Date: Oct 2019


######### Functions ##########

## A function to take a sample of size n from a population "popn" and return its mean
myexperiment <- function(popn,n){
    pop_sample <- sample(popn, n, replace = FALSE)
    return(mean(pop_sample))
}

## Calculate means using a for loop without preallocation:
loopy_sample1 <- function(popn, n, num){
	result1 <- vector() #Initialize empty vector of size 1 
	for(i in 1:num){
		result1 <- c(result1, myexperiment(popn, n))
    }
	return(result1)
}

## To run "num" iterations of the experiment using a for loop on a vector with preallocation:
loopy_sample2 <- function(popn, n, num){
	result2 <- vector(,num) #Preallocate expected size
	for(i in 1:num){
		result2[i] <- myexperiment(popn, n)
    }
	return(result2)
}

## To run "num" iterations of the experiment using a for loop on a list with preallocation:
loopy_sample3 <- function(popn, n, num){
	result3 <- vector("list", num) #Preallocate expected size
	for(i in 1:num){
		result3[[i]] <- myexperiment(popn, n)
    }
	return(result3)
}


## To run "num" iterations of the experiment using vectorization with lapply:
lapply_sample <- function(popn, n, num){
	result4 <- lapply(1:num, function(i) myexperiment(popn, n))
	return(result4)
}

## To run "num" iterations of the experiment using vectorization with lapply:
sapply_sample <- function(popn, n, num){
	result5 <- sapply(1:num, function(i) myexperiment(popn, n))
	return(result5)
}

popn <- rnorm(1000) # Generate the population
hist(popn)#which is normally distributed


n <- 20 # sample size for each experiment
num <- 1000 # Number of times to rerun the experiment

print("The loopy, non-preallocation approach takes:" )
print(system.time(loopy_sample1(popn, n, num)))

print("The loopy, but with preallocation approach takes:" )
print(system.time(loopy_sample2(popn, n, num)))

print("The loopy, non-preallocation approach takes:" )
print(system.time(loopy_sample3(popn, n, num)))

print("The vectorized sapply approach takes:" )
print(system.time(sapply_sample(popn, n, num)))

print("The vectorized lapply approach takes:" )
print(system.time(lapply_sample(popn, n, num)))




## run a simulation that involves sampling from a population with try

x <- rnorm(50) #Generate your population
doit <- function(x){
    x <- sample(x, replace = TRUE)
    if(length(unique(x)) > 30) {#only take mean if sample was sufficient
         print(paste("Mean of this sample was:", as.character(mean(x))))
        } 
    else {
        stop("Couldn't calculate mean: too few unique points!")
        }
    }

## Try using "try" with vectorization:
result <- lapply(1:100, function(i) try(doit(x), FALSE))

## Or using a for loop:
result <- vector("list", 100) #Preallocate/Initialize
for(i in 1:100) {
    result[[i]] <- try(doit(x), FALSE)
    }
