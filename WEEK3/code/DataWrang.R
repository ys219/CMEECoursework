#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: DataWrang.R
# Desc: data wrangling exercise with using melt function ro rearrage data
# Arguments: 0
# Input:Rscript DataWrang.R
# Output: printed output in r terminal
# Date: Oct 2019


########loading data###########
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F, stringsAsFactors = F))
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T , sep = ";", stringsAsFactors = F)
class(MyData)

a<-T
head(MyData)

MyData[MyData ==""]=0

MyData <- t(MyData)
head(MyData)

colnames(MyData)

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
head(TempData)


colnames(TempData) <-MyData[1,]
##assign row name from ooriginal dataframe
head(TempData)

rownames(TempData) <- NULL
head(TempData)

rownames(TempData)
#install.packages("reshape2")
require(reshape2)
#load package
MyWrangledData <- melt(TempData, id=c("Cultivation","Block","Plot","Quadrat"),variable.name = "Species", value.name = "count")
head(MyWrangledData);tail(MyWrangledData); tail(MyWrangledData)
# melt to data and creat new varibale
MyWrangledData[,"Cultivation"] <- as.factor(MyWrangledData[,"Cultivation"])
MyWrangledData[,"Block"] <- as.factor(MyWrangledData[,"Block"])
MyWrangledData[,"Plot"] <- as.factor(MyWrangledData[,"Plot"])
MyWrangledData[,"Quadrat"] <- as.factor(MyWrangledData[,"Quadrat"])
MyWrangledData[,"count"] <- as.integer(MyWrangledData[,"count"])
str(MyWrangledData)


