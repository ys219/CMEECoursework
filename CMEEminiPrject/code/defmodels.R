## Holling model:
HollingMod = function(Xr,a,h){
  c = a*Xr/(1+h*a*Xr)
  return(c)
}

