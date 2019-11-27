#!/bin/env python3

"""profiling and export outputs"""
_appname_="blackbirds"
_author_="ys"
_version_="0.0.1"
_license_="code.program"


import cProfile

import LV1
import LV2
import LV3

cProfile.run("LV1.LV1()", sort="tottime")
cProfile.run("LV2.LV2()", sort="tottime")
cProfile.run("LV3.LV3()", sort="tottime")


