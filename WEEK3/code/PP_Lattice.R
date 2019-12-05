#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: PP_Lattice.R
# Desc: generated 3 plots from ../data/EcolArchives-E089-51-D1.csv data and saved in results in pdf
# Arguments: 0
# Input:Rscript PP_Lattice.R
# Output: ../results/Pred_Lattice.pdf; ../results/Prey_Lattice.pdf; ../results/SizeRatio_Lattice.pdf; ../results/PP_Results.csv
# Date: Oct 2019


rm(list = ls())
require(lattice)
#load package
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
#load data
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data = MyDF)
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data = MyDF)
densityplot(~log(Prey.mass/Predator.mass) | Type.of.feeding.interaction, data = MyDF)
#draw density plots
###WHAT ID PREDATOR PREY SIZE RATIO?

pdf("../results/Pred_Lattice.pdf")
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data = MyDF)
graphics.off()

pdf("../results/Prey_Lattice.pdf")
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data = MyDF)
graphics.off()

pdf("../results/SizeRatio_Lattice.pdf")
densityplot(~log(Prey.mass/Predator.mass) | Type.of.feeding.interaction, data = MyDF)
graphics.off()
##save the plots

meanpred<-tapply(MyDF$Predator.mass, MyDF$Type.of.feeding.interaction, mean)
meanprey<-tapply(MyDF$Prey.mass, MyDF$Type.of.feeding.interaction, mean)
meanpp<-tapply(MyDF$Prey.mass/ MyDF$Predator.mass, MyDF$Type.of.feeding.interaction, mean)

medpred<-tapply(MyDF$Predator.mass, MyDF$Type.of.feeding.interaction, median)
medprey<-tapply(MyDF$Prey.mass, MyDF$Type.of.feeding.interaction, median)
medpp<-tapply(MyDF$Prey.mass/ MyDF$Predator.mass, MyDF$Type.of.feeding.interaction, median)
##workout mean and median

meamed <- data.frame(predator_mean = meanpred, prey_mean = meanprey, ppratio_mean = meanpp, predator_median = medpred, prey_median = medprey, ppratio_median = medpp)
write.csv(meamed, file = "../results/PP_Results.csv")
##write the data to csv file