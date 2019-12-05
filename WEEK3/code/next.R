#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: next.R
# Desc: print odd number by using next to skip even numbers 
# Arguments: 0
# Input:Rscript next.R
# Output: printed output in r terminal
# Date: Oct 2019
for (i in 1:10){
    if ((i%%2) ==0)
    next
    print(i)
}