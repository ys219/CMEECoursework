# Remove all objects from the environment
rm(list = ls())
# Set global options
options(stringsAsFactors = F)
library(tidyr)
library(ggplot2)
library(cowplot)

#import map and gather ASV and otu information
samp_otu_map = read.table("../data/[map]sample_v_otu.tsv",sep = "\t",header = 1,row.names = 1)
samp_asv_map = read.table("../data/[map]sample_v_ASV.tsv",sep = "\t",header = 1,row.names = 1)

samp_otu_map = cbind(rownames(samp_otu_map),samp_otu_map)
samp_asv_map = cbind(rownames(samp_asv_map),samp_asv_map)


samp_otu_map = gather(samp_otu_map, key = "sample",value = "reads",c(2:ncol(samp_otu_map)))
samp_otu_map = samp_otu_map[samp_otu_map$reads>0,];colnames(samp_otu_map)[1] = "OTU"

samp_asv_map = gather(samp_asv_map,key = "sample",value = "reads",c(2:ncol(samp_asv_map)))
samp_asv_map = samp_asv_map[samp_asv_map$reads>0,];colnames(samp_asv_map)[1] = "ASV"

#import metadata and put location data on
metadata = read.table("../data/metadata_info.csv",sep = ",", header = 1)
metadata = metadata[metadata$location != "Foursites",]

loc_asv_map = merge(samp_asv_map,metadata[1:2],by = "sample")
loc_otu_map = merge(samp_otu_map,metadata[1:2],by = "sample")

# location asv information
loc_asv_info =unique(loc_asv_map[c(2,4)])
loc_asv_info$n_site = NA; loc_asv_info$site_compo = NA
for(asv in unique(loc_asv_info$ASV)){
  #extract by each asv and deal with the location information
   asv_loc = loc_asv_info[loc_asv_info$ASV == asv,]$location
   loc_asv_info[loc_asv_info$ASV == asv,]$n_site = length(asv_loc)
   if(length(asv_loc) == 1 ){
     loc_asv_info[loc_asv_info$ASV == asv,]$site_compo = "single_site_sepcific"
   }else if(length(asv_loc) == 3){
      loc_asv_info[loc_asv_info$ASV == asv,]$site_compo = "across_sites"
   }else if(length(asv_loc) == 4){
      loc_asv_info[loc_asv_info$ASV == asv,]$site_compo = "acoss_all_sites"
   }else if(length(asv_loc)==2){
      if(asv_loc[1] %in%  c("Fengcity","Foping") & asv_loc[2] %in%  c("Fengcity","Foping")){
         loc_asv_info[loc_asv_info$ASV == asv,]$site_compo = "southern_sepcific"
      }else if(asv_loc[1] %in%  c("Meicity","Yuhuangmiao") & asv_loc[2] %in%  c("Meicity","Yuhuangmiao")){
         loc_asv_info[loc_asv_info$ASV == asv,]$site_compo = "northern_sepcific"
      }else{
         loc_asv_info[loc_asv_info$ASV == asv,]$site_compo = "across_sites"
      }
   }
}



### extract otu location information
loc_otu_info =unique(loc_otu_map[c(2,4)])
loc_otu_info$n_site = NA; loc_otu_info$site_compo = NA
for(otu in unique(loc_otu_info$OTU )){
   #extract by each otu and deal with the location information
   otu_loc = loc_otu_info[loc_otu_info$OTU == otu,]$location
   loc_otu_info[loc_otu_info$OTU == otu,]$n_site = length(otu_loc)
   if(length(otu_loc) == 1 ){
      loc_otu_info[loc_otu_info$OTU == otu,]$site_compo = "single_site_sepcific"
   }else if(length(otu_loc) == 3){
      loc_otu_info[loc_otu_info$OTU == otu,]$site_compo = "across_sites"
   }else if(length(otu_loc) == 4){
      loc_otu_info[loc_otu_info$OTU == otu,]$site_compo = "acoss_all_sites"
   }else if(length(otu_loc)==2){
      if(otu_loc[1] %in%  c("Fengcity","Foping") & otu_loc[2] %in%  c("Fengcity","Foping")){
         loc_otu_info[loc_otu_info$OTU == otu,]$site_compo = "southern_sepcific"
      }else if(otu_loc[1] %in%  c("Meicity","Yuhuangmiao") & otu_loc[2] %in%  c("Meicity","Yuhuangmiao")){
         loc_otu_info[loc_otu_info$OTU == otu,]$site_compo = "northern_sepcific"
      }else{
         loc_otu_info[loc_otu_info$OTU == otu,]$site_compo = "across_sites"
      }
   }
}

# plot the asv info data:
loc_asv_info_perc = as.data.frame(table(loc_asv_info$site_compo,loc_asv_info$location))
colnames(loc_asv_info_perc) = c("site_compo","location","freq")
loc_asv_info_perc$perc = NA
for(loc in loc_asv_info_perc$location){
   loc_asv_info_perc[loc_asv_info_perc$location == loc,]$perc = loc_asv_info_perc[loc_asv_info_perc$location == loc,]$freq / sum(loc_asv_info_perc[loc_asv_info_perc$location == loc,]$freq)
}
loc_asv_info_perc[loc_asv_info_perc == 0] = NA

ASV_compo = ggplot(loc_asv_info_perc, aes(x = location, y = perc,fill = site_compo)) + 
   geom_bar(position = "fill",stat = "identity") +
   scale_y_continuous(labels = scales::percent)+
   ggtitle("ASV")+
   scale_fill_discrete(name = "detected in",labels = c("all locations","multiple locations","Northern only","single location only","Southren only"))+
   labs(y = "percentage")+
   theme_classic()


# plot the otu info data:
loc_otu_info_perc = as.data.frame(table(loc_otu_info$site_compo,loc_otu_info$location))
colnames(loc_otu_info_perc) = c("site_compo","location","freq")
loc_otu_info_perc$perc = NA
for(loc in loc_otu_info_perc$location){
   loc_otu_info_perc[loc_otu_info_perc$location == loc,]$perc = loc_otu_info_perc[loc_otu_info_perc$location == loc,]$freq / sum(loc_otu_info_perc[loc_otu_info_perc$location == loc,]$freq)
}
loc_otu_info_perc[loc_otu_info_perc == 0] = NA

otu_compo = ggplot(loc_otu_info_perc, aes(x = location, y = perc,fill = site_compo)) + 
   geom_bar(position = "fill",stat = "identity") +
   scale_y_continuous(labels = scales::percent)+
   ggtitle("OTU")+
   scale_fill_discrete(name = "detected in",labels = c("all locations","multiple locations","Northern only","single location only","Southren only"))+
   labs(y = "percentage")+
   theme_classic()



# remove the legend and merge plot
loc_comp = plot_grid(
   ASV_compo+ theme(legend.position="none"),
   otu_compo + theme(legend.position="none"),
   align = 'vh',
   labels = c("A", "B"),
   hjust = -1,
   nrow = 1
)

legend = get_legend(
   # create some space to the left of the legend
   ASV_compo + theme(legend.box.margin = margin(0, 0, 0, 12))
)
# add the legend back
plot_grid(loc_comp, legend,rel_widths = c(3, .5))


