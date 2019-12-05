#!/usr/bin/env ppython3

# Author: Y_Sun ys219@ic.ac.uk
# Script: cfexercises1.py
# Desc: testing some simple fuctions with defaults
# Arguments: 0
# Input:ipython3 cfexercises1.py
# Output: results for reach module
# Date: Oct 2019
"""function tested with default values"""
import sys
# What does each of foo_x do? 
def foo_1(x=1):
    """
    square root for input
    """
    return x ** 0.5


def foo_2(x=1, y=2):
    """
    compare the two input and return the greater one
    """
    if x > y:
        return x
    return y

def foo_3(x=3, y=1, z=2):
    """
    compare 3 numbers and return from greatest to smallest in a list
    """
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]


def foo_4(x=1):
    """return the factorial of x"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result


def foo_5(x=5): # a recursive function that calculates the factorial of x
    """output the factorial but recognise if x=1 or not
    """
    if x == 1:
        return 1
    return x * foo_5(x - 1)


def foo_6(x=3): # Calculate the factorial of x in a different way
    """
    also output fractorial, but in an alternative way
    """
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    """main function"""
    print(foo_1(4))
    print(foo_2(3,6))
    print(foo_3(3,1,6))
    print(foo_4(4))
    print(foo_5(4))
    print(foo_6(4))
    return None

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

