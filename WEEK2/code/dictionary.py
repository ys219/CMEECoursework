#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: dictionary.py
# Desc: practical that convert list to dictionary
# Arguments: 0
# Input:ipython3 dictionary.py
# Output: printed output in python terminal
# Date: Oct 2019
"""practical that convert list to dictionary"""

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 
taxa_dic={}

for i in taxa:
        taxa_dic.setdefault(i[1],set()).add(i[0])


print (taxa_dic)

