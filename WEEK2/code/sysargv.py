#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: sysargv.py
# Desc: system argument exercise in python
# Arguments: multiple
# Input:ipython3 sysargv.py <arg1><arg2>...
# Output: printed name, length and arguments in python terminal
# Date: Oct 2019

"""system argument exercise in python"""
import sys
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: " , str(sys.argv))


