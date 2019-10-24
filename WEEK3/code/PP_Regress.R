library(ggplot2)
library(nlme)
setwd('/home/yige/Documents/CMEECoursework/WEEK3/code')
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
p <- ggplot(MyDF, aes(Prey.mass, Predator.mass, color= Predator.lifestage))
p<- p + 
  scale_y_continuous(trans = "log10")+
  scale_x_continuous(trans = "log10")+
  geom_point(shape = I(3))+
  facet_grid(vars(Type.of.feeding.interaction))+
  theme_bw()+
  theme(legend.position = "bottom",legend.direction  = "horizontal",aspect.ratio = 0.5)+
  labs(x = "Prey Mass in grams", y = "Predator Mass in grams")+
  geom_smooth(method = "lm", fullrange = T)
p

?scale_x_log10
pdf("../results/PP_Regress.pdf")
print(p)
dev.off()


wranged<- subset(MyDF, select = -c(Location,Prey.mass.unit,Prey.taxon,Prey.common.name,Prey,Predator.taxon,Predator.common.name,Predator,IndividualID,In.refID,Record.number))
wranged<- tidyr::unite(wranged,"lifestageXfeedingtype",Predator.lifestage:Type.of.feeding.interaction, sep = "X")
forcsv<- subset(wranged,select = -c(Prey.mass,Predator.mass))
forcsv<-unique(forcsv)
##get all lm
models<- lmList(Predator.mass~Prey.mass | lifestageXfeedingtype, data = wranged)
##get all summary
models<-lapply(models, function(models) {
  summary(models)
})
##extract all coefficient
md<-lapply(models,function(m){
  coef(m)
})
#intercept
inter <- c()
for(i in md){
  inter<-c(inter, i[1])
}
forcsv$intercept <- inter
#slope i[2]
slope <- c()
for(i in md){
  slope<-c(slope, i[2])
}
forcsv$slope <- slope
##r^2
r2<- c()
for(i in models){
  r2<-c(r2,i$r.squared)
}
forcsv$R_squared <- r2
###fstatistics
fstats<- c()
for(i in models){
  fstats<-c(fstats,i$fstatistic[1])
}
fstats<-c(fstats,"na")
forcsv$f_statistic <- fstats
##### p value i[1,4]
pvalue <- c()
for(i in md){
  pvalue<-c(pvalue, i[2])
}
forcsv$pvalue <- pvalue


write.csv(forcsv,"../results/PP_Regress_Result.csv")

