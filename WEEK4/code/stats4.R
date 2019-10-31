setwd("../data/HandOutsandData'18")
d<-read.table("SparrowSize.txt", header = TRUE)
daphnia<-read.delim("daphnia.txt")
summary(daphnia)
par(mfrow = c(1,2))
plot(Growth.rate~Detergent ,data = daphnia)
plot(Growth.rate~Daphnia ,data = daphnia)

par(mfrow = c(1,1))
require(dplyr)
daphnia%>%
group_by(Detergent) %>%
summarise(variance = var(Growth.rate))  

hist(daphnia$Growth.rate)

seFun <- function(x){
  sqrt(var(x)/length(x))
}
detergentmean <- with(daphnia, tapply(Growth.rate, INDEX = Detergent, FUN = mean))
detergentsem <- with(daphnia, tapply(Growth.rate, INDEX = Detergent, FUN = seFun))
clonemean <- with(daphnia,tapply(Growth.rate, INDEX = Daphnia, FUN = mean))
clonesem <- with(daphnia,tapply(Growth.rate, INDEX = Daphnia, FUN = seFun))

par(mfrow =c (2,1), mar=c(4,4,1,1))
barMIds <- barplot(detergentmean, xlab = "Detergent type", ylab = "Population growth rate", ylim = c(0,5))
arrows(barMIds, detergentmean - detergentsem, barMIds, detergentmean + detergentsem, code = 3, angle = 90)

barMIds <- barplot(clonemean, xlab = "Daphnia clone", ylab = "Population growth rate", ylim = c(0,5))
arrows(barMIds, clonemean - clonesem, barMIds, clonemean + clonesem, code = 3, angle = 90)

daphniaMod <- lm(Growth.rate~Detergent+Daphnia, data = daphnia)
daphniaMod
anova(daphniaMod)
summary(daphniaMod)

detergentmean - detergentmean[1]
clonemean - clonemean[1]

daphniaANOVAMod <- aov(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaANOVAMod)

daphniaModHSD <- TukeyHSD(daphniaANOVAMod)
daphniaModHSD

par(mfrow=c(2,1))
plot(daphniaModHSD)

par(mfrow = c(2,2))
plot(daphniaMod)


######multiple regression
timber <- read.delim("timber.txt")
summary(timber)

par(mfrow = c(2,2))
boxplot(timber$volume)
boxplot(timber$girth)
boxplot(timber$height)


var(timber$volume)

var(timber$girth)

var(timber$height)

t2<-as.data.frame(subset(timber, timber$volume != "NA"))
