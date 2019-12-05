#!/usr/bin/env python3

# Author: Y_Sun_ys219@ic.ac.uk
# Script: loops.py
# Desc: for loop in python exercise
# Arguments: o
# Input:ipython3 loops.py
# Output: printed result in python terminal
# Date: Oct 2019
"""for loop in python exercise"""
# print number 1-5
for i in range(5):
    print(i)

#print the elements in list
my_list = [0,2,"geronimo!", 3.0, True, False]
for k in my_list:
    print(k)

#elements in summand were added to the provious one and printed
total = 0
summands = [0,1,11,111,1111]
for s in summands:
    total =total +s
    print(total)

# while loop
#print numbers less than 100

z=0
while z<100:
    z=z+1
    print(z)
## an infinite loop
b = True
while b:
    print("GERONIMO! infinite loop! ctrl+c to stop!")
# ctrl + c to stop!