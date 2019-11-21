#!/bin/env python3

# Author:
# Scrippt: 
# Desc:
# Input: 
# Output:
# Argument:
# Date:

"""profiling and export outputs"""

# __appname__==""
# __author__==""
# __version__==""
# __liscence__==""


import cProfile

import LV1
import LV2
# import LV3

cProfile.run("LV1.LV1()", sort="tottime")
cProfile.run("LV2.LV2()", sort="tottime")
# cProfile.run("LV3.LV3()", sort="tottime")

