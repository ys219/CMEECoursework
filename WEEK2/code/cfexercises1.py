#!/usr/bin/env ppython3
"""these functions can manipulate input data"""
import sys
# What does each of foo_x do? 
def foo_1(x=1):
    return x ** 0.5


def foo_2(x=1, y=2):
    if x > y:
        return x
    return y

def foo_3(x=3, y=1, z=2):
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
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result


def foo_5(x=5): # a recursive function that calculates the factorial of x
    if x == 1:
        return 1
    return x * foo_5(x - 1)


def foo_6(x=3): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    print(foo_1(2))
    print(foo_2(3,6))
    print(foo_3(3,1,6))
    print(foo_4(4))
    print(foo_5(4))
    print(foo_6(4))
    return None

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

