#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: apply1.R
# Desc: apply functionexercise 1
# Arguments: 0
# Input:Rscript apply1.R
# Output: printed output in r terminal
# Date: Oct 2019


#build a random matrix
M <- matrix(rnorm(100), 10, 10)

## Take the mean of each row
RowMeans <- apply(M, 1, mean)
print (RowMeans)

## Now the variance
RowVars <- apply(M, 1, var)
print (RowVars)

## By column
ColMeans <- apply(M, 2, mean)
print (ColMeans)

