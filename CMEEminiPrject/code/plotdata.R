#### plot the data by ID
for( i in unique(data[,1])){
  subs = subset(data, ID == i)
  png(file= paste("../results/",i,".png"), width = 480, height = 480)
  plot(subs$N_TraitValue~subs$ResDensity, 
       main = c("ID",as.character(i)),
       xlab = "Resource Density",
       ylab = "Traitvalue",
       pch = 16,
       col = "blue")
  dev.off()
}
