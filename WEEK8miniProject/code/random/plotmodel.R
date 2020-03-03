  # plot model
# some random data
d = seq(1,200,len = 2000)
a = seq(1,10,len=10)
h = seq(0.1,0.01,len = 10)
q = seq(-2,2,len = 41)
## Holling models:
# when the h is fixed
par(new= FALSE)
plot(d,HollingMod(d, 1, 0.1), 
     type = "l",
     ylim = c(0,20),
     main = "Holling model,Increasing a(1-10)
     when h=0.05")
par(new= TRUE)
for (i in a){
  ph=0.1
  pa=i
  fits=HollingMod(d,pa,ph)
  lines(d,fits, col = i*5)
}

# when a is fixed
plot(d,HollingMod(d, 5, 0.1), 
     type = "l",
     ylim = c(0,100),
     main = "Holling model,decreasing h(0.1-0.01)
     when a=5")
# legend(1, 95, legend=seq(0.1,0.01,len = 10),col = seq(50, 5, len = 10), cex = 0.5)
par(new= TRUE)

for (i in h){
  ph=i
  pa=5
  fits=HollingMod(d,pa,ph)
  lines(d, fits, col = i*500)
}

## generalised holling

