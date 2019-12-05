#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: tuple.py 
# Desc: practical that print seperate line by sepcies
# Arguments: o
# Input:ipython3 tuple.py
# Output: printed output in python terminal
# Date: Oct 2019

"""practical that print seperate line by sepcies"""
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species 
# Hints: use the "print" command! You can use list comprehensions!\
for i in birds:
    print("Latin:",i[0],",Common name",i[1],",body mass:",i[2],end="\n")

