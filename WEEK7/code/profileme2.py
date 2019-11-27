#!/usr/bin/env python3
"""alternative way of profiling practices"""
_appname_="blackbirds"
_author_="ys"
_version_="0.0.1"
_license_="code.program"

def my_squares(iters):
    """practice"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """practice"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """practice"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")

