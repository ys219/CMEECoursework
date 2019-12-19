# CMEE 2019 HPC excercises R code challenge G proforma

rm(list=ls()) # nothing written elsewhere should be needed to make this work

name <- "Yige Sun"
preferred_name <- "Yige"
email <- "ys219@ic.ac.uk"
username <- "ys219"
## notes: 
# plot.new would create a new plotting frame,default 
# don't worry about comments for this challenge - the number of characters used will be counted starting from here
plot.new();f=function(x=.5,y=0,d=1.6,l=.1,o=1){a=x+l*cos(d);b=y+l*sin(d);lines(c(x,a),c(y,b));if(l>0.001){f(a,b,d,.9*l,-o);f(a,b,d-.8*-o,.4*l,-o)}};f()


