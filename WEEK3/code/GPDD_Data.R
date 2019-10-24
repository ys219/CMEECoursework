setwd("/home/yige/Documents/CMEECoursework/WEEK3/code")
load("../data/GPDDFiltered.RData")
library(maps)
map("world", fill = FALSE, mar = c(0,0,0,0))
points(y=gpdd$lat, x=gpdd$long,pch=16, cex=0.5,col = "red")
####
##there spatical biases, whcich is the data might be collected from the most accessible region regions
