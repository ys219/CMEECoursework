library(lattice)
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data = MyDF)
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data = MyDF)
densityplot(~log(Prey.mass/Predator.mass) | Type.of.feeding.interaction, data = MyDF)

###WHAT ID PREDATOR PREY SIZE RATIO?

pdf("../results/Pred_Lattice.pdf",11.7,8.3)
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data = MyDF)
graphics.off()

pdf("../results/Prey_Lattice.pdf",11.7,8.3)
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data = MyDF)
graphics.off()

pdf("../results/SizeRatio_Lattice.pdf",11.7,8.3)
densityplot(~log(Prey.mass/Predator.mass) | Type.of.feeding.interaction, data = MyDF)
graphics.off()


meanpred<-tapply(MyDF$Predator.mass, MyDF$Type.of.feeding.interaction, mean)
meanprey<-tapply(MyDF$Prey.mass, MyDF$Type.of.feeding.interaction, mean)
meanpp<-tapply(MyDF$Prey.mass/ MyDF$Predator.mass, MyDF$Type.of.feeding.interaction, mean)

medpred<-tapply(MyDF$Predator.mass, MyDF$Type.of.feeding.interaction, median)
medprey<-tapply(MyDF$Prey.mass, MyDF$Type.of.feeding.interaction, median)
medpp<-tapply(MyDF$Prey.mass/ MyDF$Predator.mass, MyDF$Type.of.feeding.interaction, median)


meamed <- data.frame(predator_mean = meanpred, prey_mean = meanprey, ppratio_mean = meanpp, predator_median = medpred, prey_median = medprey, ppratio_median = medpp)
write.csv(meamed, file = "../results/PP_Results.csv")
