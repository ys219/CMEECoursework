# Remove all objects from the environment
rm(list = ls())
# Set global options
options(stringsAsFactors = F)
#
library("ggplot2")
library('tidyr')
library(plyr)
library(dplyr)
library("vegan")
library("reshape2")


#load all the data
info = read.table("../data/[INFO]sample_uniqs_OTU_count.csv", sep = "," ,header = 1)# numbers of reads, uniqs and pre/post OTUs in each samples
# 


metadata = read.table("../data/metadata_info.csv", sep = "," , header = 1)

sample_X_OTU_with_ASVs = read.table("../data/[INFO]sample_X_OTU.csv",sep = ",",header = 1)


info_plotting = info[,-4]; info_plotting = info_plotting[,-5] ; info_plotting = info_plotting[,-6:-9]
sample_X_OTU_sum = data.frame(X = sample_X_OTU_with_ASVs$X, ASVs_in_OTU = rowSums(sample_X_OTU_with_ASVs[,-1]))
plot_data = merge(info_plotting, sample_X_OTU_sum, by = "X")
colnames(plot_data)[1] = c("sample")
plot_data = merge(plot_data,metadata, by = "sample")


#gather data 
plot_data = gather(plot_data, "data_type", "frequency", c(3:6))


plot_data$data_type2 <- recode(plot_data$data_type, 'uniqs' = 'ASVs', 
                               'bef_OTU' = 'OTUs', 
                               'aft_OTU' = 'OTUs', 
                               'ASVs_in_OTU' = 'ASVs')
plot_data$filtering <- recode(plot_data$data_type, 'uniqs' = 'unfiltered',
                              'bef_OTU' = 'unfiltered',
                              'aft_OTU' = 'filtered',
                              'ASVs_in_OTU' = 'filtered')
plot_data$filtering <- relevel(as.factor(plot_data$filtering), 'unfiltered')

plot_data$type_filtering <- paste(plot_data$filtering, plot_data$data_type2)


# plot the reads against out data

reads_v_asv_otu = ggplot(data = plot_data,#[plot_data$reads <= 20000 & plot_data$frequency <= 4000,], 
       aes(x = reads, y = frequency, col = nparts)) +
  geom_point(size = 1) +
  geom_smooth(method = 'lm', formula = y ~ log(x), col = 'red', alpha = 0.6) +
  #  geom_abline(intercept = 0, slope = 1, linetype = 2) + 
  labs(x = "Number of reads", y = "Count", col = "number of specimens") + 
  scale_y_continuous(trans = 'sqrt') +
  scale_x_continuous(trans = 'sqrt') + 
  theme_bw() + 
  facet_grid(data_type2~filtering, scales = 'free')+
  theme(axis.text.x = element_text(angle = 270))

reads_v_asv_otu
md = glm(frequency~data_type2+filtering+nparts+reads, family = poisson(link = "log"), data = plot_data)
summary(md)

