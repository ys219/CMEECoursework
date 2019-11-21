def LV4 ():
    import scipy as sc
    import scipy.integrate as integrate
    import sys
    from scipy.stats import norm
    norm.rvs()
    #random variables , #which can be used to generate the gaussian fluctuation 
    def CR_t1(pops, t=0):

        Rt = pops[0]
        Ct = pops[1]
        Rt1 = Rt*(1+(r+E)*(1-Rt/k) - a * Ct )
        Ct1 = Ct*(1-z+ e * a * Rt)
        
        return sc.array([Rt1,Ct1])

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
    E = sc.stats()

    t = sc.linspace(0, 15, 1000)
    ## generate 
    R0 = 10
    C0 = 5 
    RC0 = sc.array([R0, C0])

    pops, infodict = integrate.odeint(CR_t1, RC0, t, full_output=True)

    print("the final population density is\n",str(pops[-1,0]),"for Resourses\n",pops[-1,1],"for Consumers")

    import matplotlib.pylab as p
    import matplotlib.pyplot as plt
    from matplotlib.backends.backend_pdf import PdfPages

    with PdfPages("../results/LV4_models.pdf")as pdf:
    

        f1 = p.figure()

        p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
        p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
        p.grid()
        p.legend(loc='best')
        p.xlabel('Time')
        p.ylabel('Population density')
        p.title('Consumer-Resource population dynamics\n(Discrete-time)')
        
        pdf.savefig(f1) #Save figure

        f2 = p.figure()

        p.plot(pops[:,0], pops[:,1]  , 'r-')
        p.grid()
        p.legend(loc='best')
        p.xlabel('Resource density')
        p.ylabel('Consumer density')
        p.title('Consumer-Resource population dynamics\n(Discrete time)\nr=%s,a=%s,z=%s,e=%s,k=%s'%(r,a,z,e,k))

        pdf.savefig(f2)#Save figure


LV4()