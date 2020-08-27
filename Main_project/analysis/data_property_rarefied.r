# Remove all objects from the environment
rm(list = ls())

# Set global options
options(stringsAsFactors = F)

#LOADTABLE
rare_samp_ASV = read.table("../new_data/[rare]sample_ASV.csv",sep = ",", header = TRUE)
rare_samp_filotu = read.table("../new_data/[rare]sample_unfilotu.csv", sep = ",", header = TRUE)
rare_samp_unfilotu = read.table("../new_data/[rare]sample_unfilotu.csv", sep = ",", header = TRUE)
rare_samp_uniq = read.table("../new_data/[rare]sample_uniq.csv",sep = ",", header = TRUE)

# load metadata 

metadata = read.table("../new_data/metadata_info.csv", sep = "," , header = 1)

rarefied_info_table = metadata[c(1,6)]

tmp = as.data.frame(table(rare_samp_uniq$sample)); colnames(tmp)=c("sample","uniq")
rarefied_info_table = merge(rarefied_info_table,tmp, by = "sample", all = TRUE)
tmp = as.data.frame(table(rare_samp_ASV$sample)); colnames(tmp)=c("sample","ASV")
rarefied_info_table = merge(rarefied_info_table,tmp, by = "sample", all = TRUE)
tmp = as.data.frame(table(rare_samp_unfilotu$sample)); colnames(tmp)=c("sample","unf_otu")
rarefied_info_table = merge(rarefied_info_table,tmp, by = "sample", all = TRUE)
tmp = as.data.frame(table(rare_samp_filotu$sample)); colnames(tmp)=c("sample","fil_otu")
rarefied_info_table = merge(rarefied_info_table,tmp, by = "sample", all = TRUE)


# gather data to sample level

rare_reads = unique(rare_samp_uniq[1]);rare_reads$rare_read = NA
for(samp in unique(rare_samp_uniq$sample)){
  tmp = sum(na.omit(rare_samp_uniq[rare_samp_uniq$sample == samp,]$reads))
  rare_reads[rare_reads$sample == samp,]$rare_read = tmp
}


rm(tmp,rare_samp_ASV,rare_samp_filotu,rare_samp_unfilotu,rare_samp_uniq,stan_samp_ASV,stan_samp_filotu,stan_samp_unfilotu,stan_samp_uniq)

  
sample_info_table = read.table("../new_data/[INFO]sample_uniqs_OTU_count.csv", sep = "," ,header = 1)# numbers of reads, uniqs and pre/post OTUs in each samples
colnames(sample_info_table)[1] = "sample"

rarefied_info_table = merge(rarefied_info_table,sample_info_table[1:2],by = "sample", all =TRUE)
rarefied_info_table = merge(rarefied_info_table, rare_reads, by = "sample", all = TRUE )


#gather data 
rarefied_info_table = gather(rarefied_info_table, "data_type", "frequency", c(3:6))


rarefied_info_table$data_type2 = recode(rarefied_info_table$data_type, 'uniq' = 'ASVs', 
                               'unf_otu' = 'OTUs', 
                               'fil_otu' = 'OTUs', 
                               'ASV' = 'ASVs')
rarefied_info_table$filtering = recode(rarefied_info_table$data_type, 'uniq' = 'unfiltered',
                              'unf_otu' = 'unfiltered',
                              'fil_otu' = 'filtered',
                              'ASV' = 'filtered')

rarefied_info_table$filtering = relevel(as.factor(rarefied_info_table$filtering), 'unfiltered')

rarefied_info_table$type_filtering = paste0(rarefied_info_table$filtering, "_",rarefied_info_table$data_type2)

# plot

rarefied_bolin_table = rarefied_info_table[rarefied_info_table$nparts %in% c(1,25,50,100,150),][is.na(rarefied_info_table$frequency) == FALSE,]
rarefied_bolin_table$nparts = as.factor(rarefied_bolin_table$nparts)
rarefied_bolin_table = na.omit(rarefied_bolin_table)

ggplot(data = rarefied_bolin_table, mapping = aes(x = nparts,y = frequency))+
  scale_y_log10()+
  geom_violin()+
  geom_boxplot(width = 0.1)+
  stat_summary(fun=mean, geom="line", aes(group=1))+ 
  facet_grid(data_type2~filtering, scales = 'free')+
  theme_bw()+
  labs(y = "count",x = "Number of specimen")


