
import os
os.chdir('/home/yige/Documents/CMEECoursework/WEEK8miniProject/code')
import lmfit ## for customised model fitting
import numpy as np ## for linear & polynomial model fitting
import pandas as pd ## for data handling
import random

## Define Functions##
def lmf_holling(param,Xr,data = None):
    """this is describing Type II functional response by Holling in 1959.
    It is modifed for using lmfit
    Args:
        param(lmfit.parameter.parameters): contain the dictionary for parameters
    Returns:
        C(float): number of prey be attacked in unit time """
    vals = param.valuesdict()
    a = vals['a']
    h = vals['h']
    C = (a*Xr)/(1+a*h*Xr)
    if data is None:
        return C
    return C - data

def lmf_g_holling(param,Xr,data = None):
    """this is describing generalised functional response by Holling in 1959
    It is modifed for using lmfit
    Args:
        param(lmfit.parameter.parameters): contain the dictionary for parameters
    Returns:
        C(float): number of prey be attacked in unit time"""
    vals = param.valuesdict()
    a = vals['a']
    h = vals['h']
    q = vals['q']
    C = (a*Xr**(q+1))/(1 + a*h*Xr**(q+1))
    if data is None:
        return C
    return C - data





## starting values ##

# handling time (h) in Holling model

def find_h(ylist):
    """this function will estimate the starting value of h
    Args:
        ylist(list): list of number of prey be attacked in unit time
    Returns:
        h(float): the predicted starting value of handling time"""
    ylist = tuple(ylist)
    y_max = max(ylist)
    h = 1/y_max
    return h

# searching rate (a) in Holling model-typeII
def find_a(ylist,Xlist):
    """this function will estimate the starting value for of a
    Args:
        ylist(list): list of number of prey be attacked in unnit time
        Xlist(list): list of resource density
    Returns:
        a (float) : search rate"""
    ylist = tuple(ylist)
    Xlist = tuple(Xlist)
    max_index = ylist.index(np.max(ylist))## index(position of maximum value)
    x = np.array(Xlist[0:max_index+1])## trimmed off the data after max data+transform to array(to workout slope)
    y = np.array(ylist[0:max_index+1])## trimmed off the data after max data
    # slope:
    m = (len(x) * np.sum(x*y) - np.sum(x) * np.sum(y)) / (len(x)*np.sum(x*x) - np.sum(x) ** 2)
    return m

def find_q():
    """this function will work rut the q for generalised holling model
    Returns:
        q (float):randomly generated number between -2 to 2
    """
    q = random.gauss(1,0.5)# mean = 1, stedv = 0.5
    return q

## other useful functions

## def sum of square function for R_square(=1-chi/sum of square) calculation.
def sum_of_sq(y,exp):
    """to calculate the total sum of square(this is for R square calculation)
    Args:
        y(series/array/list): a series of input values
    Returns:
        SS(folat): total sum of square
    """
    mean=sum(exp)/len(exp)
    SS=sum([(i-mean)**2 for i in y])
    return SS



## import data##
fitting_data = pd.read_csv("../data/fitting_data.csv")

fitting_data = pd.read_csv("../data/CRat.csv")
fitting_data.head()
fitting_data = fitting_data[['ID','ResDensity','N_TraitValue']]



output_frame = pd.DataFrame(columns=
['ID',
'a_hol','h_hol','AIC_hol','BIC_hol','R_hol',
'a_gen','h_gen','q_gen','AIC_gen','BIC_gen','R_gen',
'k_hol_I','AIC_hol_I','BIC_hol_I','R_hol_I',
'p3_c0','p3_c1','p3_c2','p3_c3', 'AIC_p3','BIC_p3','R_p3',
'p2_c0','p2_c1','p2_c2', 'AIC_p2','BIC_p2','R_p2'])


## main loop##

for id in np.unique(fitting_data['ID']):
    fitting_set = fitting_data[fitting_data['ID'] == id].sort_values(by = 'ResDensity') #subset the dataset by IDs, sort the order by x
    x_array = fitting_set["ResDensity"]
    y_array = fitting_set["N_TraitValue"]
    
    try:#Hollinng type II:
        a_est = find_a(y_array,x_array)#starting values
        h_est = find_h(y_array)
        params = lmfit.Parameters()# add to parameters for model fitting:
        params.add('a',value = a_est,min=0)
        params.add('h',value = h_est,min=0)
        hol_fit_output = lmfit.minimize(lmf_holling, params, args = (x_array, y_array))#actual fittiing happens!
        hol_coeff = hol_fit_output.params.valuesdict()
        hol_a = hol_coeff['a']# output
        hol_h = hol_coeff['h']# output
        hol_aic = hol_fit_output.aic# output
        hol_bic = hol_fit_output.bic# output
        hol_rsq = 1-hol_fit_output.chisqr/sum_of_sq(y_array)# output    
    except BaseException:
        hol_a = None
        hol_h = None
        hol_aic = None
        hol_bic = None
        hol_rsq = None
        
    try:#generalised Holling:
        # a_est = find_a(y_array, x_array)#get starting values
        # h_est = find_h(y_array)
        q_est = find_q()
        params = lmfit.Parameters()#add to parameters for model fitting:
        params.add('q', value= q_est,min = 0)
        params.add('a', value= hol_a, min=hol_a)
        params.add('h', value= hol_h, min=hol_h)
        g_hol_output = lmfit.minimize(lmf_g_holling, params, args = (x_array, y_array))# model fitting
        g_hol_coeff = g_hol_output.params.valuesdict()
        g_hol_a = g_hol_coeff['a']# output
        g_hol_h = g_hol_coeff['h']# output
        g_hol_q = g_hol_coeff['q']# output
        g_hol_aic = g_hol_output.aic# output
        g_hol_bic = g_hol_output.bic# output
        g_hol_rsq = 1-g_hol_output.chisqr/sum_of_sq(y_array)# output
    except BaseException:
        g_hol_a = None
        g_hol_h = None
        g_hol_q = None
        g_hol_aic = None
        g_hol_bic = None
        g_hol_rsq = None
        
    try:
        poly_3 = lmfit.models.PolynomialModel(3)
        poly_3_param = poly_3.guess(y_array, x= x_array) # starting values ##optentially not needed
        poly_3_fit = poly_3.fit(y_array, poly_3_param ,x = x_array) # actual fitting
        # data to store and export
        p3_c0 = poly_3_fit.best_values['c0']# output
        p3_c1 = poly_3_fit.best_values['c1']# output
        p3_c2 = poly_3_fit.best_values['c2']# output
        p3_c3 = poly_3_fit.best_values['c3']# output
        p3_aic= poly_3_fit.aic # AIC
        p3_bic= poly_3_fit.bic # BIC
        p3_rs = 1 - poly_3_fit.chisqr/sum_of_sq(y_array) # R square
    except BaseException:
        p3_c0 = None
        p3_c1 = None
        p3_c2 = None
        p3_c3 = None
        p3_aic= None
        p3_bic= None
        p3_rs = None
    
    try:
        holling_one = lmfit.models.LinearModel()
        hol_one_param = holling_one.guess(y_array, x=x_array)
        hol_one_output = holling_one.fit(y_array, hol_one_param, x = x_array)
        # data to store and export
        k_hol_I = hol_one_output.best_values['slope']
        # b_hol_I = hol_one_output.best_values['intercept']
        AIC_hol_I= hol_one_output.aic # AIC
        BIC_hol_I= hol_one_output.bic # BIC
        R_hol_I = 1 - hol_one_output.chisqr/sum_of_sq(y_array) # R square
    except BaseException:
        k_hol_I = None
        # b_hol_I = None
        AIC_hol_I= None
        BIC_hol_I= None
        R_hol_I = None
    
    try:
        poly_2 = lmfit.models.PolynomialModel(2)
        poly_2_param = poly_2.guess(y_array, x= x_array) # starting values ##optentially not needed
        poly_2_fit = poly_2.fit(y_array, poly_2_param ,x = x_array) # actual fitting
        # data to store and export
        p2_c0 = poly_2_fit.best_values['c0']# output
        p2_c1 = poly_2_fit.best_values['c1']# output
        p2_c2 = poly_2_fit.best_values['c2']# output
        p2_aic= poly_2_fit.aic # AIC
        p2_bic= poly_2_fit.bic # BIC
        p2_rs = 1 - poly_2_fit.chisqr/sum_of_sq(y_array) # R square
    except BaseException:
        p2_c0 = None
        p2_c1 = None
        p2_c2 = None
        p2_aic= None
        p2_bic= None
        p2_rs = None
    
    output_frame.loc[id] = [str(id), 
    hol_a, hol_h, hol_aic, hol_bic, hol_rsq, 
    g_hol_a, g_hol_h, g_hol_q, g_hol_aic, g_hol_bic, g_hol_rsq, 
    k_hol_I,AIC_hol_I,BIC_hol_I,R_hol_I,
    p3_c0, p3_c1, p3_c2, p3_c3, p3_aic, p3_bic, p3_rs,
    p2_c0,p2_c1,p2_c2,p2_aic,p2_bic,p2_rs]


output_frame.to_csv(r'/home/yige/Documents/CMEECoursework/WEEK8miniProject/data/fitting_output.csv', index= False, header= True)










###############################################
#####################sandbox###################
###############################################
# output_frame
# # output_frame = pd.DataFrame(columns=['ID','a_hol','h_hol','AIC_hol','BIC_hol','R_hol'])

# output_frame.loc[39982] = [str(39982),output_coeff['a'],output_coeff['h'],fit_output.aic,fit_output.aic,1-fit_output.chisqr/sum_of_sq(test_y),None,None,None,None,None,None]
# output_frame



## the for loop:
test_set = fitting_data[fitting_data["ID"] == 2].sort_values(by = 'ResDensity')  # subset a dataset
test_y = test_set["N_TraitValue"]
test_x = test_set["ResDensity"]

# hollingII
a_est = find_a(test_y,test_x) # starting values
h_est = find_h(test_y) # starting values
p=lmfit.Parameters()# def a parameter list
p.add('a',value=a_est, min=0)# add parameter name, starting values
p.add('h',value=h_est, min=0)
# p.add('q',value=find_q(), min = 0)
# p=params.valuesdict()

fit_output = lmfit.minimize(lmf_holling,p, args = (test_x,test_y)) # actual lmfit
output_coeff = fit_output.params.valuesdict()#extract the output coef
# output_coeff['a'] ; output_coeff['h'] ; output_coeff['q'] # coefficient output
# fit_output.aic #AIC
# fit_output.bic #BIC
# fit_output.chisqr
a_para = output_coeff['a'] ; h_para = output_coeff['h']  # coefficient output

1-fit_output.chisqr/sum_of_sq(test_y)# R square
## to do actual NLLS fitting
a_est = find_a(test_y,test_x) # starting values
h_est = find_h(test_y) # starting values
c_est = find_c()
p=lmfit.Parameters()# def a parameter list
p.add('a',value=a_est, min=0)# add parameter name, starting values
p.add('h',value=h_est, min=0)
p.add('c',value=c_est, min = 0)
# p=params.valuesdict()

fit_output = lmfit.minimize(lmf_g_holling,p, args = (test_x,test_y)) # actual lmfit
output_coeff = fit_output.params.valuesdict()#extract the output coef
output_coeff['a'] ; output_coeff['h'] ; output_coeff['c'] # coefficient output
fit_output.aic #AIC
fit_output.bic #BIC
fit_output.chisqr
fit_output.chisqr/sum_of_sq(test_y)# R square

fit_output.chisqr# R square

fit_output.success # check success of model
fit_output.params
holling_one(test_x)
fit_output.
p


# ## polynomial 做三项，四项，?五项
# poly_4 = lmfit.models.PolynomialModel(4)
# poly_param = poly_4.guess(test_y,x= test_x) # starting values
# poly_fit = poly_4.fit(test_y,poly_param,x = test_x) # actual fitting
# poly_fit.best_values['c0'] # coefficient output
# poly_fit.aic # AIC
# poly_fit.bic # BIC
# 1 - poly_fit.chisqr/sum_of_sq(test_y) # R square
poly_4 = lmfit.models.PolynomialModel(4)
poly_4_param = poly_4.guess(y_array,x= x_array) # starting values ##optentially not needed
poly_4_fit = poly_4.fit(test_y, x = test_x) # actual fitting

# ##Note：
# # 1 按id subset
# # 2 转换两列 为list #目前看来不必了
# # 3 sort by Xrlist --data.sort_values("Salary", axis = 0, ascending = True, inplace = True, na_position ='first')
# #
# # test=list(np.unique(fitting_data["ID"])) ## 提取ID 列， 转化为list， unique ，
# # test
# # test.index(max(test)) ## max 的 序号
# # test=test[300:test.index(max(test))]
# # for i in test :
# #     holling(i,0.8,0.8)

# #export csv

holling_one = lmfit.models.LinearModel()
hol_one_param = holling_one.guess(test_y, x=test_x)
hol_one_output = holling_one.fit(test_y, hol_one_param, x = test_x)
hol_one_output.best_values['slope']
hol_one_param

