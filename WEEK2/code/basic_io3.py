#!/usr/bin/env python3

# Author: Y_Sun_ys219@ic.ac.uk
# Script: basic_io3.py
# Desc: save dictionary in binary form and print with python
# Arguments: 0
# Input:ipython3 basic_io3.py
# Output: a binary file testp.p saved in sandbox and contents printed out on terminal
# Date: Oct 2019

"""save dictionary in binary form and print with python"""
#############################
# STORING OBJECTS
#############################
# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key": 11}

import pickle

f = open('../sandbox/testp.p','wb') ## note the b: accept binary files
pickle.dump(my_dictionary, f)
f.close()

## Load the data again
f = open('../sandbox/testp.p','rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)
