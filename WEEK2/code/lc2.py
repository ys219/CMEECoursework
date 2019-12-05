#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: lc2.py
# Desc: practical to get certain rainfall month
# Arguments: 0
# Input:ipython3 lc2.py
# Output: printed output in python terminal
# Date: Oct 2019
"""python practical"""
# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
)
# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
rainfall100=[(i[0],i[1]) for i in rainfall if i[1]>100] 
print(rainfall100)
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 
rainfall50=[i[0] for i in rainfall if i[1]<50] 
print(rainfall50)
# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

for i in [50,100]:
    if i==100:
        r100=[(a[0],a[1]) for a in rainfall if a[1]>i]
        print(r100)
    else:
        r50=[a[0] for a in rainfall if a[1]<i]
        print(r50)

