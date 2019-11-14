def LV2 ():
    import scipy as sc
    import scipy.integrate as integrate
    import sys

    def dCR_dt(pops, t=0):

        R = pops[0]
        C = pops[1]
        dRdt = r * R*(1-R/k) - a * R * C 
        dCdt = -z * C + e * a * R * C
        
        return sc.array([dRdt, dCdt])

    if len(sys.argv) != 5:
        r = 1.0
        a = 0.1
        z = 1.5
        e = 0.75
    else:
        r = float(sys.argv[1])
        a = float(sys.argv[2])
        z = float(sys.argv[3])
        e = float(sys.argv[4])
    k = 50

    t = sc.linspace(0, 15, 1000)
    ## generate 
    R0 = 10
    C0 = 5 
    RC0 = sc.array([R0, C0])

    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    print("the final population density is\n",str(pops[-1,0]),"for Resourses\n",pops[-1,1],"for Consumers")

    import matplotlib.pylab as p
    import matplotlib.pyplot as plt
    from matplotlib.backends.backend_pdf import PdfPages

    with PdfPages("../results/LV2_models.pdf")as pdf:
    

        f1 = p.figure()

        p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
        p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
        p.grid()
        p.legend(loc='best')
        p.xlabel('Time')
        p.ylabel('Population density')
        p.title('Consumer-Resource population dynamics')
        
        pdf.savefig(f1) #Save figure

        f2 = p.figure()

        p.plot(pops[:,0], pops[:,1]  , 'r-')
        p.grid()
        p.legend(loc='best')
        p.xlabel('Resource density')
        p.ylabel('Consumer density')
        p.title('Consumer-Resource population dynamics\nr=%s,a=%s,z=%s,e=%s,k=%s'%(r,a,z,e,k))

        pdf.savefig(f2)#Save figure


LV2()