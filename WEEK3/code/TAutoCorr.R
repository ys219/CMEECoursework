#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: TAutoCorr.R
# Desc: practical, work out the correlation of n-1 pair of years with given data
# Arguments: 0
# Input:Rscript TAutoCorr.R
# Output: printed output in r terminal
# Date: Oct 2019


#load("/home/yige/Documents/CMEECoursework/WEEK3/data/KeyWestAnnualMeanTemperature.RData")
load("../data/KeyWestAnnualMeanTemperature.RData")
y1901<-ats$Temp[-100]
y1902<-ats$Temp[-1]
corcoe<-cor(y1901,y1902)

rcorcoe <- c()

for (i in 1:10000){
  rtemp<- sample(ats$Temp,size = length(ats$Temp),replace = FALSE)
  ry1901<-rtemp[-100]
  ry1902<-rtemp[-1]
  rcorcoe[i]<- cor(ry1901,ry1902)
}

for (i in rcorcoe){
  a <- 0
  if(i>corcoe){a = a+1}
  p=a/length(rcorcoe)
}

print(paste("p-value=",p))

