#### model selection function
# whs4Better<- function(m1,m2){
#   aics=as.data.frame(AIC(m1,m2))
#   row.names(aics[which(aics[,2]==min(aics[,2])),])
# }

aics=as.data.frame(AIC(lms,plms))
row.names(aics[which(aics[,2]==min(aics[,2])),])


# rm(aics)
# aics = matrix(nrow = 0, ncol = 2)
# row.names(aics[1,])
# rbind(aics, c(1,2))
# mds=c(lms,plms)
myaic= as.data.frame(matrix(,ncol = 4,nrow = 1))
for( i in unique(data[,1])){
  subs = subset(data, ID == i)
  lms=lm(TraitValue~ResDensity_SI_VALUE, data = subs)
  plms= lm(TraitValue~poly(ResDensity_SI_VALUE,2), data = subs)
  cubic= try(lm(TraitValue~poly(ResDensity_SI_VALUE,3), data = subs),silent = T)
  
  ## calculate and compare AICs(sometimes cubic wouldn't work, use if to ignore it.)
  if(class(cubic)!="try-error"){
    aics=as.data.frame(AIC(lms,plms,cubic))
    myaic= rbind(myaic,t(aics))
  }else{
    aics=as.data.frame(AIC(lms,plms))
    myaic= rbind(myaic,t(aics))
  }
  print(paste(as.character(i),row.names(aics[which(aics[,2]==min(aics[,2])),])))
}
head(myaic)
t(aics)
