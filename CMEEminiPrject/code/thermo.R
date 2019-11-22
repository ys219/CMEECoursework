#### packages loading

require(repr)
require(minpack.lm)

##### data importing
data = read.csv("../data/ThermRespData.csv",header = TRUE)
colnames(data)

#### plot the data by ID
for( i in unique(data[,2])){
  subs = subset(data, ID == i)
  png(file= paste("../thermo//",i,".png"), width = 480, height = 480)
  plot(subs$OriginalTraitValue~subs$ConTemp, 
       main = c("ID",as.character(i)),
       xlab = "Resource Density",
       ylab = "Traitvalue",
       pch = 16,
       col = "blue")
  dev.off()
}

#### input the models

##polynomial model:
polynimial= function(t,B0,B1,B2,B3){
  B = B0+B1*x+B2*t^2+B3*t^3
  return(B)
}

##Briere model:

briere= function(t,B0){
  B = B0 * t(max(t))
}