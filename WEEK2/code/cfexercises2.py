#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: cfexercises2.py
# Desc: these functions combined loops and confitionals and allow you print lots of hello
# Arguments: 0
# Input:ipython3 cfexercises2.py
# Output: hello in python interpretor
# Date: Oct 2019

"""these functions combined loops and confitionals and allow you print lots of hello with multiple ways"""
for j in range(12):
    if j % 3 == 0:
        print('hello')
#print hello at the all 3a that smaller than input number

for j in range(15):
     if j % 5 == 3:
        print('hello')
     elif j % 4 == 3:
        print('hello')
# print hello at 4a+3 or 5a+3 that smaller than x

z = 0
while z != 15:
    print('hello')
    z = z + 3
#print hello at 3a that smaller than x

z = 12
while z < 100:
    if z == 31:
        for k in range(7):
            print('hello')
    elif z == 18:
        print('hello')
    z = z + 1
#print 1 hello when x is greater than 18, and 7 more hello when it greater than 31 



