#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: GPDD_Data.R
# Desc: mapt of data from Global Population Dynamics Database 
# Arguments: 0
# Input:Rscript GPDD_Data.R
# Output: printed output plot in r terminal
# Date: Oct 2019


setwd("/home/yige/Documents/CMEECoursework/WEEK3/code")
load("../data/GPDDFiltered.RData")
library(maps)
map("world", fill = FALSE, mar = c(0,0,0,0))
points(y=gpdd$lat, x=gpdd$long,pch=16, cex=0.5,col = "red")
####
##there spatical biases, whcich is the data might be collected from the most accessible region regions
