#!/bin/env python3

"""profiling and export outputs"""
_appname_="run_LV"
_author_="ys"
_version_="0.0.1"
_license_="code.program"


import cProfile
import pstats

import LV1
import LV2
import LV3
import LV4
import LV5
##import the script as module



cProfile.run("LV1.LV1()", filename= "../results/LV1_prof.out")
cProfile.run("LV2.LV2()", filename= "../results/LV2_prof.out")
cProfile.run("LV3.LV3()", filename= "../results/LV3_prof.out")
cProfile.run("LV4.LV4()", filename= "../results/LV4_prof.out")
cProfile.run("LV5.LV5()", filename= "../results/LV5_prof.out")
## call the functions in scripts and save output profile time

LV1p = pstats.Stats("../results/LV1_prof.out")
LV2p = pstats.Stats("../results/LV2_prof.out")
LV3p = pstats.Stats("../results/LV3_prof.out")
LV4p = pstats.Stats("../results/LV4_prof.out")
LV5p = pstats.Stats("../results/LV5_prof.out")
## read the output file.

print("**********LV1 profile***************")
LV1p.strip_dirs().sort_stats("tottime","cumulative").print_stats(5)
print("**********LV2 profile***************")
LV2p.strip_dirs().sort_stats("tottime","cumulative").print_stats(5)
print("**********LV3 profile***************")
LV3p.strip_dirs().sort_stats("tottime","cumulative").print_stats(5)
print("**********LV4 profile***************")
LV4p.strip_dirs().sort_stats("tottime","cumulative").print_stats(5)
print("**********LV5 profile***************")
LV5p.strip_dirs().sort_stats("tottime","cumulative").print_stats(5)

# strip_dirs(), remove irrelevent path; sort_stats,sort by working time and total time, print_stats, print first 5 lines
# cprofile usage and analysis tool: http://yunpiao.pub/2017/03/22/Python/2017-2-10%20python%20%E6%80%A7%E8%83%BD%E5%88%86%E6%9E%90%20cProfile/