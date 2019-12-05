#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: basic_io.R
# Desc: fundimental sytax of read and write the csvfiles
# Arguments:0  
# Input:Rscript basic_io.R
# Output: ../results/MyData.csv
# Date: Oct 2019
MyData <- read.csv("../data/trees.csv", header = TRUE) # import with headers

write.csv(MyData, "../results/MyData.csv") #write it out as a new file

write.table(MyData[1,], file = "../results/MyData.csv",append=TRUE) # Append to it

write.csv(MyData, "../results/MyData.csv", row.names=TRUE) # write row names

write.table(MyData, "../results/MyData.csv", col.names=FALSE) # ignore column names
