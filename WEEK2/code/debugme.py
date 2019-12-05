#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: debugme.py
# Desc: debugging with pdb
# Arguments: 0
# Input:ipython3 debugme.py
# Output: error in python terminal, then use %pdb to debug
# Date: Oct 2019
"""debugging with pdb"""
def creatabug(x):
    """function with bug"""
    y= x ** 4
    z= 0.
    y=y/z
    return y

creatabug(25)
