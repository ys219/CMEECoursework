#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: boilerplate.py
# Desc: a boilerplate
# Arguments: python script sample
# Input:ipython3 boilerplate.py
# Output: printed statement
# Date: Oct 2019

"""Description of this program or application.
you can use several line"""

_appname_="boilerplate"
_author_="ys"
_version_="0.0.1"
_license_="code.program"

import sys

def main(argv):
    """main entry point of the program"""
    print('This is a boillerplate')
    return 0
##would able take input with argv
if __name__ == "__main__":
    """make sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)
