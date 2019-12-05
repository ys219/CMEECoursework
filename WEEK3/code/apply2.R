#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: apply2.R
# Desc: apply funtion exeercise 
# Arguments: 0
# Input:Rscript apply2.R
# Output: printed output in r terminal
# Date: Oct 2019


SomeOperation <- function(v){ # (What does this function do?)multiply the elements by 100
  if (sum(v) > 0){
    return (v * 100)
  }
  return (v)
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))