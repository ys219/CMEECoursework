#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: oaks_debugme.py
# Desc:debugging the finding oak trees script
# Arguments: 0
# Input:in ipython3: run oaks_debugme.py -v
# Output: printed results in python terminal
# Date: Oct 2019
"""debugging the finding oak trees script"""
import csv
import sys
import doctest
 
#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 
    >>> is_an_oak('Fraxinus excelsior')
    False

    >>> is_an_oak('Quercus cerris')
    True

    >>> is_an_oak('Quercus petraea')
    True

    >>> is_an_oak('Pinus sylvestris')
    False
    """
    if 'quercus' in name.lower():
        return True
    else:
        return False


def main(argv): 
    """main function"""
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    csvwrite.writerow(['Genus', 'species']) 
    oaks = set()
    for row in taxa:
        if row[0] != ('Genus'):
            print(row)
            print ("The genus is: ") 
            print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()