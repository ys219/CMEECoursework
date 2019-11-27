#!/usr/bin/env python3
"""profiling test"""
_appname_="blackbirds"
_author_="ys"
_version_="0.0.1"
_license_="code.program"



def my_squares(iters):
    """practice"""
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """practice"""
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    """practice"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")