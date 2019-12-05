#### load packages

require(repr)
require(minpack.lm)

#### import data
data = read.csv("../data/CRat.csv", header = TRUE)
colnames(data)
# wranged = subset(data,)

sub= subset(data, ID=="687")
#### define models
## linear models:
  for( i in unique(data[,1])){
    subs = subset(data, ID == i)
    lms=lm(TraitValue~ResDensity_SI_VALUE, data = subs)
    plms= lm(TraitValue~poly(ResDensity_SI_VALUE,2), data = subs)
    cubic= try(lm(TraitValue~poly(ResDensity_SI_VALUE,3), data = subs),silent = T)
    
    ## calculate and compare AICs
    if(class(cubic)!="try-error"){
      aics=as.data.frame(AIC(lms,plms,cubic))
    }else{
      aics=as.data.frame(AIC(lms,plms))
    }
    print(paste(as.character(i),row.names(aics[which(aics[,2]==min(aics[,2])),])))
  }
  

## polynomial models:



#### starting value, need to be improved

slope = coef(lm(TraitValue~ResDensity, data = sub))[2]
asc= rnorm(6, mean = slope , sd = slope/2)
startV = matrix(NA, ncol = 2, nrow = 0)

for(i in asc){
  holl<- nlsLM(N_TraitValue~HollingMod(ResDensity,a,h), data = sub, start = list(a= i, h = max(sub$TraitValue)))
  startV = rbind(startV,c(i,AIC(holl)))
}
a = startV[which(startV[,2] == min(startV[,2]))]
a
slope

Holl<- nlsLM(N_TraitValue~HollingMod(ResDensity,a,h), data = subs, start = list(a= a_opt, h=.01))

len= seq(min(data$ResDensity),max(data$ResDensity), len=2000)
coef(Hollfit)["a"]
coef(Hollfit)["h"]
fitting= HollingMod(len, coef(Hollfit)["a"], coef(Hollfit)["h"])
lines(len, fitting, col = 'red', lwd=2)
## Generalized Holling model:



aics
