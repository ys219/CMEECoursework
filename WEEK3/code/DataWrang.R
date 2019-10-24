########loading data###########
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F, stringsAsFactors = F))
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T , sep = ";", stringsAsFactors = F)
class(MyData)

a<-T
head(MyData)

MyData[MyData ==""]=0

MyData <- t(MyData)
head(MyData)

colnames(MyData)

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
head(TempData)


colnames(TempData) <-MyData[1,]
##assign row name from ooriginal dataframe
head(TempData)

rownames(TempData) <- NULL
head(TempData)

rownames(TempData)
#install.packages("reshape2")
require(reshape2)

MyWrangledData <- melt(TempData, id=c("Cultivation","Block","Plot","Quadrat"),variable.name = "Species", value.name = "count")
head(MyWrangledData);tail(MyWrangledData); tail(MyWrangledData)

MyWrangledData[,"Cultivation"] <- as.factor(MyWrangledData[,"Cultivation"])
MyWrangledData[,"Block"] <- as.factor(MyWrangledData[,"Block"])
MyWrangledData[,"Plot"] <- as.factor(MyWrangledData[,"Plot"])
MyWrangledData[,"Quadrat"] <- as.factor(MyWrangledData[,"Quadrat"])
MyWrangledData[,"count"] <- as.integer(MyWrangledData[,"count"])
str(MyWrangledData)


