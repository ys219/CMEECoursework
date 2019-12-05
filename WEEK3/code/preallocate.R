#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: preallocate.R
# Desc: pre-llocate the position for number in memory
# Arguments: 0
# Input:Rscript preallocate.R
# Output: printed output in r terminal
# Date: Oct 2019


a <- NA
for (i in 1:10) {
  a <- c(a, i)
  print(a)
  print(object.size(a))
}

a <- rep(NA, 10)

for (i in 1:10) {
  a[i] <- i
  print(a)
  print(object.size(a))
}
