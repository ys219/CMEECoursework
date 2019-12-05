#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: Vectorize1.R
# Desc: Use the vectorization rather than loop, then compare the system time 
# Arguments: 0
# Input:Rscript Vectorize1.R
# Output: printed output in r terminal
# Date: Oct 2019


M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M){
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]){
    for (j in 1:Dimensions[2]){
      Tot <- Tot + M[i,j]
    }
  }
  return (Tot)
}
 
print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))