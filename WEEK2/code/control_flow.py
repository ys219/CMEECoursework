#!/usr/bin/env python3
"""some functions exwmplifying the use of control statements """
##docstring, would be shown in help()
_appname_="boilerplate"
_author_="ys"
_version_="0.0.1"
_license_="code.program"

import sys ##introduce a modelue

def even_or_odd(x=0): # if not specified, x should take value 0.
##(x=0, set a default)
    """Find whether a number x is even or odd."""
    if x % 2 == 0: #The conditional if
        return "%d is Even!" % x
    return "%d is Odd!" % x

#even_or_odd(7653)


def largest_divisor_five(x=120):
    ##default value x=120
    """Find which is the largest divisor of x among 2,3,4,5."""
    largest = 0
    if x % 5 == 0:
        largest = 5
    elif x % 4 == 0: #means "else, if"
        largest = 4
    elif x % 3 == 0:
        largest = 3
    elif x % 2 == 0:
        largest = 2
    #alined in order from large to small to achieve the function largest divisor.
    else: # When all other (if, elif) conditions are not met
        return "No divisor found for %d!" % x # Each function can return a value or a variable.
        ##if we got retur here whole processes will be stoped
    return "The largest divisor of %d is %d" % (x, largest)

#largest_divisor_five(112)

def is_prime(x=70):
    """Find whether an integer is prime."""
    for i in range(2, x): #  "range" returns a sequence of integers
        if x % i == 0:
            #if x can be divided by any number between 2 and x, it is not a prime
          print("%d is not a prime: %d is a divisor" % (x, i)) 
          return False
    print("%d is a prime!" % x)
    return True
    #if return True is necessary? NO, you could return None, it will still print it's a prime, but you have to return something.
    ##however if i am using while True, use return false would allow sme to cease the proccess.

#is_prime()
#is_prime(31)

def find_all_primes(x=22):
    """Find all the primes up to x"""
    allprimes = []
    for i in range(2, x + 1):
        ##allows all the numbers between 2(smallest prime) and x be divided by x 
      if is_prime(i):
          #using the function that set up just now
        allprimes.append(i)
        #
    print("There are %d primes between 2 and %d" % (len(allprimes), x))
    return allprimes

#find_all_primes()
#find_all_primes(100)

def main(argv):
    print(even_or_odd(22))
    print(even_or_odd(33))
    print(largest_divisor_five(120))
    print(largest_divisor_five(121))
    print(is_prime(60))
    print(is_prime(59))
    print(find_all_primes(100))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

