#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: break.R
# Desc: exercise of adding break point in a loop, so it allows jump out of the loop or cease the process
# Arguments: 0
# Input:Rscript break.R
# Output: printed output in r terminal
# Date: Oct 2019
i <- 0 #Initialize i
	while(i < Inf) {
		if (i == 10) {
			break 
             } # Break out of the while loop! 
		else { 
			cat("i equals " , i , " \n")
			i <- i + 1 # Update i
	}
}