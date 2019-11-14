def LV1():
    import scipy as sc
    import scipy.integrate as integrate

    def dCR_dt(pops, t=0):

        R = pops[0]
        C = pops[1]
        dRdt = r * R - a * R * C 
        dCdt = -z * C + e * a * R * C
        
        return sc.array([dRdt, dCdt])

    r = 1.
    a = 0.1 
    z = 1.5
    e = 0.75

    t = sc.linspace(0, 15, 1000)
    ## generate 
    R0 = 10
    C0 = 5 
    RC0 = sc.array([R0, C0])

    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    import matplotlib.pylab as p
    import matplotlib.pyplot as plt
    from matplotlib.backends.backend_pdf import PdfPages
    
    with PdfPages("../results/LV1_models.pdf")as pdf:
        
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
        p.title('Consumer-Resource population dynamics')


        pdf.savefig(f2) #Save figure


LV1()