# Remove all objects from the environment
rm(list = ls())
# Set global options
options(stringsAsFactors = F, digits = 2)

library(vegan)
library(ggplot2)
library(tidyr)
library(cowplot)
## import uniq characteristic table
sample_uniq_property = read.table("../data/[INFO]uniq_property_table.csv",sep = ",",header = 1)

# filter out stopcodons and chimer
filtering_with_r = sample_uniq_property[sample_uniq_property$stop_codon == 0,]
filtering_with_r = filtering_with_r[filtering_with_r$chime == "False",]

alpha1_uniqs = filtering_with_r[filtering_with_r$denoise_a1 == "False",][1]
alpha2_uniqs = filtering_with_r[filtering_with_r$denoise_a2 == "False",][1]
alpha3_uniqs = filtering_with_r[filtering_with_r$denoise_a3 == "False",][1]
alpha4_uniqs = filtering_with_r[filtering_with_r$denoise_a4 == "False",][1]
alpha5_uniqs = filtering_with_r[filtering_with_r$denoise_a5 == "False",][1]
alpha6_uniqs = filtering_with_r[filtering_with_r$denoise_a6 == "False",][1]

rm(sample_uniq_property,filtering_with_r)

# load metadata for spliting ecosample
metadata = read.table("../data/metadata_info.csv", sep = ",", header = TRUE)
metadata = metadata[-8]
metadata = na.omit(metadata[startsWith(metadata$sample,"RNMB"),])


metadata$eco_sam = paste0(metadata$location,';',metadata$trap,"_",metadata$sizeclass)
lib_to_ecosamp = metadata[c(1,8)]
rm(metadata)

# load the beast: sample_uniq map
samp_uniq_table = read.table("../data/[map]sample_v_unqs.tsv",sep = "\t",header = 1, row.names = 1)

#ensure the empty libraries were removed
lib_to_ecosamp = lib_to_ecosamp[lib_to_ecosamp$sample %in% colnames(samp_uniq_table),]

ecosamp_uniq_table = as.data.frame(matrix(NA,nrow = nrow(samp_uniq_table), ncol = length(unique(lib_to_ecosamp$eco_sam))))
rownames(ecosamp_uniq_table) = rownames(samp_uniq_table)
colnames(ecosamp_uniq_table) = unique(lib_to_ecosamp$eco_sam)

## turn the library uniq map into eco_samp_unq_map

for(s in unique(lib_to_ecosamp$eco_sam)){
  lib = lib_to_ecosamp[lib_to_ecosamp$eco_sam == s,]$sample
  ecosamp_uniq_table[s] = rowSums(samp_uniq_table[lib])
}

# make an ecosample infromation table
eco_samp_info = cbind(lib_to_ecosamp[2],sapply(strsplit(lib_to_ecosamp$eco_sam,";"),function(x) x[1]),sapply(strsplit(lib_to_ecosamp$eco_sam,";"),function(x) x[2]))
colnames(eco_samp_info)[2:3] = c("location","trap_size") 
eco_samp_info = cbind(eco_samp_info, sapply(strsplit(eco_samp_info$trap_size, "_"),function(x) x[1]),sapply(strsplit(eco_samp_info$trap_size, "_"),function(x) x[2]))
eco_samp_info = eco_samp_info[-3]
colnames(eco_samp_info)[3:4] = c("trap","size")
eco_samp_info = unique(eco_samp_info)

# clean up
rm(samp_uniq_table,lib_to_ecosamp)



## filter and generate the map:
alpha1_uniqs = ecosamp_uniq_table[alpha1_uniqs$uniq,]
alpha2_uniqs = ecosamp_uniq_table[alpha2_uniqs$uniq,]
alpha3_uniqs = ecosamp_uniq_table[alpha3_uniqs$uniq,]
alpha4_uniqs = ecosamp_uniq_table[alpha4_uniqs$uniq,]
alpha5_uniqs = ecosamp_uniq_table[alpha5_uniqs$uniq,]
alpha6_uniqs = ecosamp_uniq_table[alpha6_uniqs$uniq,]

# workout shann index for
shann_alpha1 = as.data.frame(diversity(t(alpha1_uniqs)))
shann_alpha2 = as.data.frame(diversity(t(alpha2_uniqs)))
shann_alpha3 = as.data.frame(diversity(t(alpha3_uniqs)))
shann_alpha4 = as.data.frame(diversity(t(alpha4_uniqs)))
shann_alpha5 = as.data.frame(diversity(t(alpha5_uniqs)))
shann_alpha6 = as.data.frame(diversity(t(alpha6_uniqs)))

shann_v_alpha = cbind(shann_alpha1,shann_alpha2,shann_alpha3,shann_alpha4,shann_alpha5,shann_alpha6)
shann_v_alpha = as.data.frame(shann_v_alpha);colnames(shann_v_alpha) = c(1:6)
shann_v_alpha = cbind(rownames(shann_v_alpha),shann_v_alpha);colnames(shann_v_alpha)[1]="eco_sample"
shann_v_alpha = gather(shann_v_alpha,key = "alpha",value = "shannon_index", c(2:7))

shann_density_plot = ggplot(shann_v_alpha,aes(x = shannon_index, fill = alpha))+
  geom_density(data = subset(shann_v_alpha, alpha == "1"),alpha = 0.2)+
  geom_density(data = subset(shann_v_alpha, alpha == "2"),alpha = 0.2)+
  geom_density(data = subset(shann_v_alpha, alpha == "3"),alpha = 0.2)+
  geom_density(data = subset(shann_v_alpha, alpha == "4"),alpha = 0.2)+
  geom_density(data = subset(shann_v_alpha, alpha == "5"),alpha = 0.2)+
  geom_density(data = subset(shann_v_alpha, alpha == "6"),alpha = 0.2)+
  theme_bw()+
  scale_fill_discrete(name = "Denoising alpha")+
  labs(x = "Shannon's alpha diversity index")

rm(shann_alpha1,shann_alpha2,shann_alpha3,shann_alpha4,shann_alpha5,shann_alpha6)



## same progress on fisher alpha diversity index
fisher_alpha1 = fisher.alpha(t(alpha1_uniqs))
fisher_alpha2 = fisher.alpha(t(alpha2_uniqs))
fisher_alpha3 = fisher.alpha(t(alpha3_uniqs))
fisher_alpha4 = fisher.alpha(t(alpha4_uniqs))
fisher_alpha5 = fisher.alpha(t(alpha5_uniqs))
fisher_alpha6 = fisher.alpha(t(alpha6_uniqs))

fisher_v_alpha = cbind(fisher_alpha1,fisher_alpha2,fisher_alpha3,fisher_alpha4,fisher_alpha5,fisher_alpha6)
fisher_v_alpha = as.data.frame(fisher_v_alpha);colnames(fisher_v_alpha) = c(1:6)
fisher_v_alpha = gather(fisher_v_alpha,key = "alpha",value = "fisher_index")


fisher_density_plot = ggplot(fisher_v_alpha,aes(x = fisher_index, fill = alpha))+
  geom_density(data = subset(fisher_v_alpha, alpha == "1"),alpha = 0.2)+
  geom_density(data = subset(fisher_v_alpha, alpha == "2"),alpha = 0.2)+
  geom_density(data = subset(fisher_v_alpha, alpha == "3"),alpha = 0.2)+
  geom_density(data = subset(fisher_v_alpha, alpha == "4"),alpha = 0.2)+
  geom_density(data = subset(fisher_v_alpha, alpha == "5"),alpha = 0.2)+
  geom_density(data = subset(fisher_v_alpha, alpha == "6"),alpha = 0.2)+
  theme_bw()+
  labs(x = "Fisher's alpha diversity index")

rm(fisher_alpha1,fisher_alpha2,fisher_alpha3,fisher_alpha4,fisher_alpha5,fisher_alpha6)

# plots
density_plot = plot_grid(
  shann_density_plot+ theme(legend.position="none"),
  fisher_density_plot + theme(legend.position="none"),
  align = 'vh',
  labels = c("A", "B"),
  hjust = -1,
  nrow = 1
)

legend = get_legend(
  # create some space to the left of the legend
  shann_density_plot+ theme(legend.box.margin = margin(0, 0, 0, 12))
)
# add the legend back
plot_grid(density_plot, legend,rel_widths = c(3, .4))


##ANOVA to test if the distribution differ across alpha
shannon_anova = aov(shannon_index~alpha,shann_v_alpha)
summary(shannon_anova)

TukeyHSD(x = shannon_anova,"alpha",conf.level = 0.95)


fisher_anova = aov(fisher_index~alpha,fisher_v_alpha)
summary(fisher_anova)

TukeyHSD(x = fisher_anova,"alpha",conf.level = 0.95)



# load the property data again
sample_uniq_property = read.table("../data/[INFO]uniq_property_table.csv",sep = ",",header = 1)

# filter out stopcodons and chimer
filtering_with_r = sample_uniq_property[sample_uniq_property$stop_codon == 0,]
filtering_with_r = filtering_with_r[filtering_with_r$chime == "False",]

alpha1_uniqs = filtering_with_r[filtering_with_r$denoise_a1 == "False",][1]
alpha2_uniqs = filtering_with_r[filtering_with_r$denoise_a2 == "False",][1]
alpha3_uniqs = filtering_with_r[filtering_with_r$denoise_a3 == "False",][1]
alpha4_uniqs = filtering_with_r[filtering_with_r$denoise_a4 == "False",][1]
alpha5_uniqs = filtering_with_r[filtering_with_r$denoise_a5 == "False",][1]
alpha6_uniqs = filtering_with_r[filtering_with_r$denoise_a6 == "False",][1]

rm(sample_uniq_property,filtering_with_r)

##generate the location table:
loc_samp_table = as.data.frame(matrix(NA, nrow = nrow(ecosamp_uniq_table),ncol = length(unique(eco_samp_info$location))))
rownames(loc_samp_table) = rownames(ecosamp_uniq_table)
colnames(loc_samp_table) = unique(eco_samp_info$location)
## turn the library uniq map into eco_samp_unq_map

for(l in unique(eco_samp_info$location)){
  lib = eco_samp_info[eco_samp_info$location == l,]$eco_sam
  loc_samp_table[l] = rowSums(ecosamp_uniq_table[lib])
}

## filter and generate the map:
alpha1_uniqs = loc_samp_table[alpha1_uniqs$uniq,]
alpha2_uniqs = loc_samp_table[alpha2_uniqs$uniq,]
alpha3_uniqs = loc_samp_table[alpha3_uniqs$uniq,]
alpha4_uniqs = loc_samp_table[alpha4_uniqs$uniq,]
alpha5_uniqs = loc_samp_table[alpha5_uniqs$uniq,]
alpha6_uniqs = loc_samp_table[alpha6_uniqs$uniq,]


shann_alpha1 = as.data.frame(diversity(t(alpha1_uniqs)))
shann_alpha2 = as.data.frame(diversity(t(alpha2_uniqs)))
shann_alpha3 = as.data.frame(diversity(t(alpha3_uniqs)))
shann_alpha4 = as.data.frame(diversity(t(alpha4_uniqs)))
shann_alpha5 = as.data.frame(diversity(t(alpha5_uniqs)))
shann_alpha6 = as.data.frame(diversity(t(alpha6_uniqs)))

shann_v_alpha = cbind(shann_alpha1,shann_alpha2,shann_alpha3,shann_alpha4,shann_alpha5,shann_alpha6)
shann_v_alpha = as.data.frame(shann_v_alpha);colnames(shann_v_alpha) = c(1:6)
shann_v_alpha = cbind(rownames(shann_v_alpha),shann_v_alpha);colnames(shann_v_alpha)[1]="location"
shann_v_alpha = gather(shann_v_alpha,key = "alpha",value = "shannon_index", c(2:7))

shann_bar = ggplot(shann_v_alpha, aes(x = location, y = shannon_index, fill = alpha))+
  geom_bar(stat = "identity", position = "dodge")+
  theme_bw()+
  scale_fill_discrete(name = "Denoising alpha")+
  labs(y = "Shannon's alpha diversity index")

## same progress on fisher alpha diversity index
fisher_alpha1 = fisher.alpha(t(alpha1_uniqs))
fisher_alpha2 = fisher.alpha(t(alpha2_uniqs))
fisher_alpha3 = fisher.alpha(t(alpha3_uniqs))
fisher_alpha4 = fisher.alpha(t(alpha4_uniqs))
fisher_alpha5 = fisher.alpha(t(alpha5_uniqs))
fisher_alpha6 = fisher.alpha(t(alpha6_uniqs))

fisher_v_alpha = cbind(fisher_alpha1,fisher_alpha2,fisher_alpha3,fisher_alpha4,fisher_alpha5,fisher_alpha6)
fisher_v_alpha = as.data.frame(fisher_v_alpha);colnames(fisher_v_alpha) = c(1:6)
fisher_v_alpha = cbind(rownames(fisher_v_alpha),fisher_v_alpha);colnames(fisher_v_alpha)[1]="location"
fisher_v_alpha = gather(fisher_v_alpha,key = "alpha",value = "fisher_index", c(2:7))

fish_bar = ggplot(fisher_v_alpha, aes(x = location, y = fisher_index, fill = alpha))+
  geom_bar(stat = "identity", position = "dodge")+
  theme_bw()+
  scale_fill_discrete(name = "Denoising alpha")+
  labs(y = "Fisher's alpha diversity index")


# plots
bar_plot = plot_grid(
  shann_bar+ theme(legend.position="none"),
  fish_bar + theme(legend.position="none"),
  align = 'vh',
  labels = c("A", "B"),
  hjust = -1,
  nrow = 1
)

bar_legend = get_legend(
  # create some space to the left of the legend
  shann_bar+ theme(legend.box.margin = margin(0, 0, 0, 12))
)
# add the legend back
plot_grid(bar_plot, bar_legend,rel_widths = c(3, .4))



# generate jaccard index

beta_alpha1_j = betadiver(t(alpha1_uniqs),"j")
beta_alpha2_j = betadiver(t(alpha2_uniqs),"j")
beta_alpha3_j = betadiver(t(alpha3_uniqs),"j")
beta_alpha4_j = betadiver(t(alpha4_uniqs),"j")
beta_alpha5_j = betadiver(t(alpha5_uniqs),"j")
beta_alpha6_j = betadiver(t(alpha6_uniqs),"j")

beta_alpha1_j = dist(beta_alpha1_j)
beta_alpha2_j = dist(beta_alpha2_j)
beta_alpha3_j = dist(beta_alpha3_j)
beta_alpha4_j = dist(beta_alpha4_j)
beta_alpha5_j = dist(beta_alpha5_j)
beta_alpha6_j = dist(beta_alpha6_j)

