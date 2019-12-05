#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: boilerplate.R
# Desc: function exercises in r language
# Arguments: 0
# Input:Rscript boilerplate.R
# Output: printed output in r terminal
# Date: Oct 2019

# A boilerplate R script

MyFunction <- function(Arg1, Arg2){

  # Statements involving Arg1, Arg2:
  print(paste("Argument", as.character(Arg1), "is a", class(Arg1))) # print Arg1's type
  print(paste("Argument", as.character(Arg2), "is a", class(Arg2))) # print Arg2's type

  return (c(Arg1, Arg2)) #this is optional, but very useful
}

MyFunction(1,2) #test the function
MyFunction("Riki","Tiki") #A different test