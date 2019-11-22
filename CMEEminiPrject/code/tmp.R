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
lms=lm(TraitValue~ResDensity_SI_VALUE, data = subs)
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
plms= lm(TraitValue~poly(ResDensity_SI_VALUE,2), data = subs)


#### starting value, need to improve



Hollfit<- nlsLM(N_TraitValue~HollingMod(ResDensity,a,h), data = data, start = list(a= .1, h=.01))

len= seq(min(data$ResDensity),max(data$ResDensity), len=2000)
coef(Hollfit)["a"]
coef(Hollfit)["h"]
fitting= HollingMod(len, coef(Hollfit)["a"], coef(Hollfit)["h"])
lines(len, fitting, col = 'red', lwd=2)
## Generalized Holling model:



aics
