#!/bin/env python3

# Author: Y_Sun_ys219@ic.ac.uk
# Script: basic_csv.py
# Desc: read the sepcies name from testcsv.csv file in data folder, print it; and write the species and bodymassto a new file bodymass.csv in data folder
# Arguments: 0
# Input:ipython3 basic_csv.py
# Output: printed species name and body mass; saved bodymass.csv file in data folder
# Date: Oct 2019
import csv

""" read the sepcies name from testcsv.csv file in data folder, print it; and write the species and bodymassto a new file bodymass.csv in data folder
"""
# Read a file containing:
# 'Species','Infraorder','Family','Distribution','Body mass male (Kg)'
f = open('../data/testcsv.csv','r')

csvread = csv.reader(f)
temp = []
for row in csvread:
    temp.append(tuple(row))
    print(row)
    print("The species is", row[0])

f.close()

# write a file containing only species name and Body mass
f = open('../data/testcsv.csv','r')
g = open('../data/bodymass.csv','w')

csvread = csv.reader(f)
csvwrite = csv.writer(g)
for row in csvread:
    print(row)
    csvwrite.writerow([row[0], row[4]])

f.close()
g.close()
print("\n")
print(temp)
