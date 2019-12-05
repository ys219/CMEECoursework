#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: scope.py
# Desc: variable scope exercise(what is global scope?)
# Arguments: 0
# Input:ipython3 scope.py
# Output: printed output in python terminal
# Date: Oct 2019
"""variable scope exercise(what is global scope?)"""
_a_global = 10

def a_function():
    """scope exercise """
    _a_global=5
    _a_local=4
    print("Inside the function, the value is ", _a_global)
    print("Inside the function, the value is ", _a_local)
    return None

a_function()

print("Outside the function the value is ", _a_global)


_a_global=10

def a_function():
    """scope exercise"""
    global _a_global
    _a_global=5
    _a_local=4
    print("Inside the function, the value is ", _a_global)
    print("Inside the function, the value is ", _a_local)
    return None

a_function()

print("Outside the function the value is ", _a_global)




_a_global=10 #define a global variable

if _a_global >=5: #condition
    _b_global =_a_global+5 #action

def _a_function(): #defining a function
    """scope exercise"""
    _a_global = 5 #local variable
    if _a_global >= 5: #local condition
        _b_global = _a_global + 5 #local action
        _a_local = 4  #define a local variable
    print("Inside the function, the value of global _a_ is ", _a_global)
    print("Inside the function, the value gllobal _b_ is ", _b_global)
    print("Inside the function, the value is local _a_ is ", _a_local)
    return None

_a_function()

print("Outside the function the value of global a is ", _a_global)
print("Outside the function the value of global b is ", _b_global)