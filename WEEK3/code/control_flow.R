#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: control_flow.R
# Desc: exercises of control flow function in r language, using for and while loop
# Arguments: 0
# Input:Rscript control_flow.R
# Output: printed result in r terminal
# Date: Oct 2019

## If statement
a <- TRUE
if (a == TRUE){
	print ("a is TRUE")
	} else {
	print ("a is FALSE")
}

## If statement on a single line
z <- runif(1) ## uniformly distributed random number
if (z <= 0.5) {print ("Less than a half")}

# For loop using a sequence
for (i in 1:10){
	j <- i * i
	print(paste(i, " squared is", j ))
}

## For loop over vector of strings
for(species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')){
  print(paste('The species is', species))
}

## for loop using a vector
v1 <- c("a","bc","def")
for (i in v1){
	print(i)
}

## While loop
i <- 0
while (i<10){
	i <- i+1
	print(i^2)
}

