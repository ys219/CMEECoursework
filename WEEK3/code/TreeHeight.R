#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: TreeHeight.R
# Desc: load trees.csv and work out the height then output as a csv file
# Arguments: 0
# Input:Rscript TreeHeight.R
# Output: ../results/TreeHts.csv; printed output in r terminal
# Date: Oct 2019

# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"
treedata<-as.data.frame(read.csv("../data/trees.csv"),header = TRUE)

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  print(paste("Tree height is:", height))

  return (height)
}

treedata$Tree.Height.m <- TreeHeight(treedata$Distance.m, treedata$Angle.degrees)

write.csv(treedata, file = "../results/TreeHts.csv")
