#!/usr/binenv python3
"""these functions combined loops and confitionals and allow you print lots of hello"""
import sys

def hello_1(x=12) :
    """hello_1 allows you print hello at the all 3a that smaller than input number"""
    for j in range(12):
        if j % 3 == 0:
            print('hello')

def hello_2(x=15) :
    """hello_2 allows you print hello at 4a+3 or 5a+3 that smaller than x"""
    for j in range(x):
        if j % 5 ==3:
            print('hello')
        elif j %4 ==3:
            print('hello')

def hello_3(x=15):
    """hello_3 allows you print hello at 3a that smaller than x"""
    z=0
    while z <=x:
        print('hello')
        z=z+3

def hello_4(x=100):
    """hello_4 allows you print 1 hello when x is greater than 18, and 7 more hello when it greater than 31 """
    z=12
    while z<x:
        if z== 31:
            for k in range(7) :
                print("hello")
        elif z==18:
            print('hello')
        z=z+1

def main(argv):
    print(hello_1(18))
    print(hello_2(20))
    print(hello_3(20))
    print(hello_4(120))
    return None

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

