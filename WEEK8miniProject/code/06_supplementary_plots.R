setwd('/home/yige/Documents/CMEECoursework/WEEK8miniProject/code/')
rm(list = ls())# clear workspace
# require("ggplot2")
# import raw data
raw_data = read.csv('../data/CRat.csv', header = TRUE, stringsAsFactors = FALSE)
# import fitting output data
out_put = read.csv('../data/fitting_output.csv', header = TRUE, stringsAsFactors = FALSE)

citation = unique(subset(raw_data, select = c(ID,Citation)))
citation = data.frame(
  ID = citation$ID
  ,Citation = gsub("^[[0-9]+]","",citation$Citation))

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

citation[citation$ID == 2,2]
for(id in unique(raw_data$ID)){
  sub_raw = subset(raw_data, ID == id)
  sub_out = subset(out_put, ID == id)
  mod_x = seq(min(sub_raw$ResDensity), max(sub_raw$ResDensity), length.out = 100)
  hol_y = HollingMod(mod_x, sub_out$a_hol, sub_out$h_hol)
  g_hol_y = g_HollingMod(mod_x, sub_out$a_gen, sub_out$h_gen, sub_out$q_gen)
  hol_I_y = Holling_I(mod_x, sub_out$a_hol_I)
  p3_y = poly_3(mod_x, sub_out$p3_c0, sub_out$p3_c1, sub_out$p3_c2, sub_out$p3_c3)
  p2_y = poly_2(mod_x, sub_out$p2_c0, sub_out$p2_c1, sub_out$p2_c2)
## plots
  png(file= paste0("../results/supplementary_plots/",id,".png"), width = 960, height = 960)
  plot(sub_raw$ResDensity, sub_raw$N_TraitValue, 
          ylim = c(0,  max(sub_raw$N_TraitValue)+max(sub_raw$N_TraitValue)*0.2),
          main = paste0("ID=",id),
          xlab = "Resource Density",
          ylab = "Consumption Rate",
          pch = 16,
       mtext(text = citation[citation$ID == id,2],side = 4))
  try({
    lines(mod_x, hol_I_y, lty = 5, col = 1 ,lwd = 3)
    lines(mod_x, hol_y, lty= 4,col = 2,lwd = 3)
    lines(mod_x, g_hol_y, lty = 3, col = 3,lwd = 3)
    lines(mod_x, p3_y,lty = 2, col = 4,lwd = 2)
    lines(mod_x,p2_y, lty = 1, col = 5,lwd = 2)
    legend("bottomright", inset = 0.02, legend = c("Hol I","Hol II","Hol III", "Cubic",  "Quadratic"), lty = 5:1,lwd = 3, col = 1:5, box.lty = 0, cex = 2, bg = "transparent")
    },
    silent = TRUE
    )
  dev.off()
}
  





