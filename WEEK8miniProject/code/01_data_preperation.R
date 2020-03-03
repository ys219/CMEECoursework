#!bin/env Rscript

# title: 01_data_preperation.R
# Description: Creating subsets from raw data and handling problematic/missing data
# run: Rscript 01_data_preperation.R
# output: tabulated subsets for fitting and further steps
# Nov 2019

rm(list = ls())
##import data##
fr_data = read.csv('../data/CRat.csv',header = T)


       
# ## 1 remove empty columns##
# col_rm = c() ## create empty vector to store column that been removed
# col_not_full=c()
# for(i in 1:ncol(fr_data)){ 
#   if (length(unique(fr_data[i])) != length(unique(fr_data$ID)) && is.na(unique(fr_data[i]))){## check if all the values in that column are the same, if so then check whether that value is NA
#     #col_rm = c(col_rm , i) ## record the column number
#     col_not_full = c(col_not_full,i)
#   }
# }
# ncol(fr_data)
unique(fr_data$ORIGINAL_TraitID)
# 
# # colnames(fr_data[col_rm]) ## if want to check what are they
# fr_data = fr_data[-col_rm] ## remove it



## 2 

# extract minimum data for model fitting:
min_fitting_data = fr_data[c("ID","N_TraitValue","ResDensity")]

# export the data 
write.csv(min_fitting_data, "../data/fitting_data.csv")


## plotting the data to explore
for( i in unique(fitting_data[,1])){
  subs = subset(fitting_data, ID == i)
  png(file= paste0("../results/",i,".png"), width = 480, height = 480)
  plot(subs$N_TraitValue~subs$ResDensity_SI_VALUE, 
       main = c("ID",as.character(i)),
       xlab = "Resource Density(#ResIndvi/arena(m^2or m^3))",
       ylab = "Traitvalue(#ResIndiv/(#ConIndiv*s))",
       pch = 16,
       col = "blue")
  dev.off()
}

