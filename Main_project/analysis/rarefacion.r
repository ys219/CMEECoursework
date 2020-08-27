# Remove all objects from the environment
rm(list = ls())

# Set global options
options(stringsAsFactors = F)

# Load libraries ----------------------------------------------------------
# Load the libraries (packages) you need for your data manipulation and 
# analysis. Remember, the order of loading is sometimes important.

library(tidyr)
library(plyr)
library(dplyr)
library(reshape2)
library(vegan)
library(ggplot2)
# library(ape)


rare_value = 1300# which is the averge number of reads across libraries

##### rarefy each map
sample_uniq_map = read.table("../data/[map]sample_v_unqs.tsv",sep = "\t",header = TRUE, row.names = 1, comment.char = '')
sample_uniq_map = t(sample_uniq_map)

#rarefy
rare_samp_uniq = sample_uniq_map[rowSums(sample_uniq_map)>=rare_value,]
rare_samp_uniq = rrarefy(sample_uniq_map,rare_value)
rare_samp_uniq = rare_samp_uniq[rowSums(rare_samp_uniq)==rare_value,]
rare_samp_uniq = as.data.frame(rare_samp_uniq)
rare_samp_uniq = cbind(rownames(rare_samp_uniq),rare_samp_uniq)
rare_samp_uniq = gather(rare_samp_uniq,key = "uniq",value = "reads",c(2:ncol(rare_samp_uniq)))
rare_samp_uniq = rare_samp_uniq[rare_samp_uniq$reads >0,]
#remove map
rm(sample_uniq_map)



##map2 samp_asv
sample_ASV_map =read.table("../data/[map]sample_v_ASV.tsv", sep = "\t",header = 1, row.names = 1)
sample_ASV_map =t(sample_ASV_map)

#rarefy
rare_samp_ASV = sample_ASV_map[rowSums(sample_ASV_map)>=rare_value,]
rare_samp_ASV = rrarefy(sample_ASV_map,rare_value)
rare_samp_ASV = rare_samp_ASV[rowSums(rare_samp_ASV)==rare_value,]
rare_samp_ASV = as.data.frame(rare_samp_ASV)
rare_samp_ASV = cbind(rownames(rare_samp_ASV),rare_samp_ASV)
rare_samp_ASV = gather(rare_samp_ASV,key = "ASV",value = "reads",c(2:ncol(rare_samp_ASV)))
rare_samp_ASV = rare_samp_ASV[rare_samp_ASV$reads >0,]
#remove map
rm(sample_ASV_map)


##map3 sample_filotu
sample_filotu_map = read.table("../data/[map]sample_v_otu.tsv",sep = "\t",header = TRUE,row.names = 1)
sample_filotu_map = t(sample_filotu_map)

#rarefy
rare_samp_filotu = sample_filotu_map[rowSums(sample_filotu_map)>=rare_value,]
rare_samp_filotu = rrarefy(sample_filotu_map,rare_value)
rare_samp_filotu = rare_samp_filotu[rowSums(rare_samp_filotu) ==rare_value,]
# rare_samp_filotu = rare_samp_filotu[rowSums(rare_samp_filotu)>0,]
rare_samp_filotu = as.data.frame(rare_samp_filotu)
rare_samp_filotu = cbind(rownames(rare_samp_filotu),rare_samp_filotu)
rare_samp_filotu = gather(rare_samp_filotu,key = "filotu",value = "reads",c(2:ncol(rare_samp_filotu)))
rare_samp_filotu = rare_samp_filotu[rare_samp_filotu$reads >0,]
#remove map
rm(sample_filotu_map)



##map4 unfil otu
sample_unfilotu_map = read.table("../data/[map]sample_v_unfilotu.tsv",sep = "\t",header = 1, row.names = 1)
sample_unfilotu_map = t(sample_unfilotu_map)

#rarefy
rare_samp_unfilotu = sample_unfilotu_map[rowSums(sample_unfilotu_map)>=rare_value,]
rare_samp_unfilotu = rrarefy(sample_unfilotu_map,rare_value)
rare_samp_unfilotu = rare_samp_unfilotu[rowSums(rare_samp_unfilotu)==rare_value,]
rare_samp_unfilotu = as.data.frame(rare_samp_unfilotu)
rare_samp_unfilotu = cbind(rownames(rare_samp_unfilotu),rare_samp_unfilotu)
rare_samp_unfilotu = gather(rare_samp_unfilotu,key = "unf_otu",value = "reads",c(2:ncol(rare_samp_unfilotu)))
rare_samp_unfilotu = rare_samp_unfilotu[rare_samp_unfilotu$reads >0,]
#remove map
rm(sample_unfilotu_map)



#### rename all the colnames
colnames(rare_samp_uniq)[1] = "sample"
colnames(rare_samp_ASV)[1] = "sample"
colnames(rare_samp_unfilotu)[1] = "sample"
colnames(rare_samp_filotu)[1] = "sample"

write.csv(rare_samp_uniq,"../data/[rare]sample_uniq.csv",row.names = FALSE)
write.csv(rare_samp_ASV,"../data/[rare]sample_ASV.csv",row.names = FALSE)
write.csv(rare_samp_unfilotu,"../data/[rare]sample_unfilotu.csv",row.names = FALSE)
write.csv(rare_samp_filotu,"../data/[rare]sample_filotu.csv",row.names = FALSE)


