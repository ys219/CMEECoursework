test_eq = function(x,a,h,q){
  y = a*x^q/(1+a*h*x^q)
  return(y)
}

x = seq(1:2000)
y = test_eq(x,3.82e-29,2.04e+04,2)
plot(y~x,type = 'l')
