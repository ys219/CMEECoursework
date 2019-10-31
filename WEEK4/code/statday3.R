x<- c(1,2,3,4,8)
y<- c(3,4,5,7,9)
statsmodel<-lm(y~x)
statsmodel
##Coefficients:
#(Intercept)            x  
#2.493        0.863  
summary(statsmodel)

anova(statsmodel)
resid(statsmodel)
cov(x,y)
var(x)
plot(y~x)

par(mfrow=c(1,1))
plot(statsmodel)


setwd("../data/HandOutsandData'18")
d<-read.table("SparrowSize.txt", header = TRUE)
x<- c(1:100)
b<- 0.5
m<- 1.5
y<-m*x+b
plot(d$Mass~d$Tarsus, ylab= "Mass(g)", xlab = "Tarsus(mm)", pch=19,cex=0.4, ylim=c(-5,38), xlim=c(0,22))
plot(d2$Mass~d2$Tarsus, ylab= "Mass(g)", xlab = "Tarsus(mm)", pch=19,cex=0.4)
abline(lm(d2$Mass~d2$Tarsus))
d1<-subset(d, d$Mass != "NA")
d2 <- subset(d1, d1$Tarsus != "NA")
statsmodel<- lm(Mass~Tarsus, data=d2)
summary(statsmodel)
hist(statsmodel$residuals)##bellshape
head(statsmodel$residuals)

d2$z.Tarsus <- scale(d2$Tarsus)
statsmodel3<-lm(Mass~z.Tarsus, data = d2)  
summary(statsmodel3)
plot(d2$Mass~d2$z.Tarsus, pch=19, cex=0.4)
abline(v=0, lty="dotted")
head(d)
str(d)
