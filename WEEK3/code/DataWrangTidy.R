########loading data###########
require(dplyr)
require(tidyr)
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F, stringsAsFactors = F))
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T , sep = ";", stringsAsFactors = F)
class(MyData)

dplyr::tbl_df(MyData)##also can do view(MyData)
MyData[MyData ==""]=0##replace the empty cell with 0

MyData <- t(MyData)#transpose it(THE MATRIX) row to colums and colums to rows, 
dplyr::tbl_df(MyData)
colnames(MyData)

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)##remove the first row
dplyr::tbl_df(TempData)


colnames(TempData) <-MyData[1,]
##assign colum name from original dataframe
dplyr::tbl_df(TempData)

rownames(TempData) <- NULL##removed  all the row names
dplyr::tbl_df(TempData)

#install.packages("reshape2")
dplyr::tbl_df(TempData)

?tidyr::gather()

MyWrangledData <- tidyr::gather(TempData, key = "Species", value = "count", -c("Cultivation","Block","Plot","Quadrat"))
dplyr::tbl_df(MyWrangledData);tail(MyWrangledData)

MyWrangledData[,"Cultivation"] <- as.factor(MyWrangledData[,"Cultivation"])
MyWrangledData[,"Block"] <- as.factor(MyWrangledData[,"Block"])
MyWrangledData[,"Plot"] <- as.factor(MyWrangledData[,"Plot"])
MyWrangledData[,"Quadrat"] <- as.factor(MyWrangledData[,"Quadrat"])
MyWrangledData[,"count"] <- as.integer(MyWrangledData[,"count"])
dplyr::glimpse(MyWrangledData)


