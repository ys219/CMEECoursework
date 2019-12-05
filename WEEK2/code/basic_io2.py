#!/usr/bin/env python3

# Author: Y_Sun_ys219@ic.ac.uk
# Script: basic_io2.py
# Desc: print numbers in newlines and save them to a file
# Arguments: 0
# Input: ipython3 basic_io2.py
# Output: save testout.txt at sandbox
# Date: Oct 2019
"""print numbers in newlines and save them to a file"""
#############################
# FILE OUTPUT
#############################
# Save the elements of a list to a file
list_to_save = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n') ## Add a new line at the end

f.close()


