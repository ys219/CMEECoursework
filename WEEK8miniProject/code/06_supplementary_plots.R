setwd('/home/yige/Documents/CMEECoursework/WEEK8miniProject/code/')
rm(list = ls())# clear workspace
# require("ggplot2")
# import raw data
raw_data = read.csv('../data/fitting_data.csv', header = TRUE, stringsAsFactors = FALSE)
# import fitting output data
out_put = read.csv('../data/fitting_output.csv', header = TRUE, stringsAsFactors = FALSE)



## functions
## Holling model:
HollingMod = function(Xr,a,h){
  c = a*Xr/(1+h*a*Xr)
  return(c)
}
## generalised holling
g_HollingMod = function(Xr, a, h, q){
  c = a*Xr^(q+1)/(1+a*h*Xr^(q+1))
  return(c)
}

Holling_I = function(Xr, k){
  y = k*Xr
  return(y)
}

## polynomial deg=3
poly_3 = function(Xr, c0, c1, c2, c3){
  c = c0+ c1*Xr+ c2*Xr^2+ c3*Xr^3
  return(c)
}
## polynomial deg=2
poly_2 = function(Xr, c0, c1, c2){
  c = c0+ c1*Xr+ c2*Xr^2
  return(c)
}


for(id in unique(raw_data$ID)){
  sub_raw = subset(raw_data, ID == id)
  sub_out = subset(out_put, ID == id)
  
  
  mod_x = seq(min(sub_raw$ResDensity), max(sub_raw$ResDensity), length.out = 100)
  hol_y = HollingMod(mod_x, sub_out$a_hol, sub_out$h_hol)
  g_hol_y = g_HollingMod(mod_x, sub_out$a_gen, sub_out$h_gen, sub_out$q_gen)
  hol_I_y = Holling_I(mod_x, sub_out$k_hol_I)
  p3_y = poly_3(mod_x, sub_out$p3_c0, sub_out$p3_c1, sub_out$p3_c2, sub_out$p3_c3)
  p2_y = poly_2(mod_x, sub_out$p2_c0, sub_out$p2_c1, sub_out$p2_c2)
## plots
  png(file= paste("../results/",id,".png"), width = 960, height = 960)
  plot(sub_raw$ResDensity, sub_raw$N_TraitValue, 
          ylim = c(0,  max(sub_raw$N_TraitValue)+max(sub_raw$N_TraitValue)*0.5),
          main = c("ID",as.character(id)),
          xlab = "Resource Density",
          ylab = "Traitvalue",
          pch = 16)
  try({
    lines(mod_x, hol_y, col = '#CC0000')
    lines(mod_x, g_hol_y, col = "#006633")
    lines(mod_x, p3_y,col = '#0033FF')
    lines(mod_x, hol_I_y, col = '#FF6600')
    lines(mod_x,p2_y)
    },
    silent = TRUE
    )
  dev.off()
}
  
