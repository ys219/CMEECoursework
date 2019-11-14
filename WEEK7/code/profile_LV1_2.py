#!/bin/env python3

# Author:
# Scrippt: 
# Desc:
# Input: 
# Output:
# Argument:
# Date:

"""profiling and export outputs"""

__appname__==""
__author__==""
__version__==""
__liscence__==""


import cProfile

import LV1
cProfile.run("LV1.LV()", sort="tottime")