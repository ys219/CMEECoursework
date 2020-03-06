#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Desc: plot fot write up
# Output: intro plot png
# Date: Mar 2020
rm(list = ls())
require(ggplot2)
x = seq(1000)# make dummy data
HollingMod = function(Xr,a,h){
  c = a*Xr/(1+h*a*Xr)
  return(c)
}
y = HollingMod(x , 0.3, 0.1)
plot_data = data.frame(x,y)
notes = data.frame(
  x = c(120,850),
  y = c(2,10.5),
  label = c("a = slope ","asymptote = 1/h")
)

png(filename = "../results/01_intro.png",width = 480, height = 480)
ggplot(plot_data,aes(x,y))+
  geom_line(color = "red")+
  theme_classic()+
  ylim(0,11)+
  geom_abline(slope = 0, intercept = 10, linetype = "dashed")+
  geom_vline(xintercept = 250, linetype = "dashed")+
  geom_text(data = notes, aes(x=x,y=y,label= label))+
  labs(x = "Resource Density", y = "Consumption rate")
try(dev.off(),silent = TRUE)
