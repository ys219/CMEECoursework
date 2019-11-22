# load modules
import pandas as pd
import  scipy as sc
import matplotlib.pylab as pl
import seaborn as sns
from lmfit import Model

# import data
data = pd.read_csv("../data/CRat.csv")
# print("Loaded{}columns.".format(len(data.columns.values)))
# data.head()

# print(data.columns.values)
# print(data.TraitUnit.unique())
# print(data.ResDensityUnit.unique())
# print(data.ID.unique())

##### define the models:
## Holling models:
# def holling(Xr, a, h, c):
#     """
#     Holling model description
#     """
#     model = a*Xr/(1+h*a*Xr)
#     residual = model - c
#     return residual
def holling(Xr, a, h):
    """
    Holling model description
    """
    c = a*Xr/(1+h*a*Xr)
    return c

def genholling(Xr, a, h, q):
    """
    Holling generalised model
    """ 
    c = a*Xr^(q+1)/(1+h*a*Xr^(q+1))
    return c
# data[data["ID"] == 39835]

# data.ResDensity[data["ID"] == 39835]


##### model fitting:
hollmodel= Model(holling)

parameters = hollmodel.fit(data.N_TraitValue, Xr = data.ResDensity_SI_VALUE, a = 0.1,h= 1e-05)
parameters.fit_report()

for i in data.ID.unique():
    
    data[data['ID'] == i]
    y = data.N_TraitValue[data['ID'] == i]
    x = data.ResDensity_SI_VALUEdata[data['ID'] == i]
    parameters = hollmodel.fit(y, x = x, a = ,h= )


data_sub_39982 = data[data["ID"]== 39982]
data_sub_39982.head


