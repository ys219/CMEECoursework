setwd("/home/yige/Documents/CMEECoursework/WEEK5/code")
library(repr);options(repr.plot.width = 4, repr.plot.height = 4)
require("minpack.lm")
##define the function
powmod <- function(x,a,b){
  return(a*x^b)
}
#load data
Mydata<- read.csv("../data/GenomeSize.csv")
head(Mydata)

##subset take out sepcific data
##data of dragonflies and omit the na
Data2fit <- subset(Mydata, Suborder == "Anisoptera")
Data2fit <- Data2fit[!is.na(Data2fit$TotalLength),]
plot(Data2fit$TotalLength, Data2fit$BodyWeight)

##load package
library(ggplot2)
##scatter plot
ggplot(Data2fit, aes(x=TotalLength, y= BodyWeight))+
  geom_point(size = (3), color = "red" )+
  theme_bw()+
  labs(y= "Body mass(mg)" , x = "Wing length (mm)")

Powfit<- nlsLM(BodyWeight ~ powmod(TotalLength, a, b), data = Data2fit, start = list(a= .1, b= .1))

summary(Powfit)
##generate data for fitting line
Length<- seq(min(Data2fit$TotalLength), max(Data2fit$TotalLength), len=200)

coef(Powfit)["a"]
coef(Powfit)["b"]

predict2plotpow<- powmod(Length, coef(Powfit)["a"], coef(Powfit)["b"])

plot(Data2fit$TotalLength, Data2fit$BodyWeight)
lines(Length, predict2plotpow, col = "blue", lwd = 2.5)


confint(Powfit)
########exercise 
exerciseAline<- function(x){
  3.94e-6* x^2.59 
}
plot(Data2fit$TotalLength, Data2fit$BodyWeight)
lines(Length, exerciseAline, col = "blue", lwd = 2.5)

ggplot(Data2fit, aes(x=TotalLength, y= BodyWeight))+
  geom_point(size = (3), color = "red" )+
  theme_bw()+
  labs(y= "Body mass(mg)" , x = "Wing length (mm)")+
  stat_function(fun = exerciseAline, geom = "line")


