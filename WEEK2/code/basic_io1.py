#!/usr/bin/env python3

# Author: Y_Sun_ys219@ic.ac.uk
# Script: basic_io1.py
# Desc: print the lines from input file
# Arguments: 0
# Input: ipython3 basic_io1.py
# Output: output the lines in test file
# Date: Oct 2019

"""output the contents, and output comtents and remvove blank lines"""
#############################
# FILE INPUT
#############################
# Open a file for reading
f = open('../sandbox/test.txt', 'r')
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
for line in f:
    print(line)

# close the file
f.close()

# Same example, skip blank lines
f = open('../sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close()