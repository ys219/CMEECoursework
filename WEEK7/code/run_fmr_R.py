#!/usr/bin/env python3
"""script to run fmr.R"""
_appname_="blackbirds"
_author_="ys"
_version_="0.0.1"
_license_="code.program"

import subprocess
try:
    subprocess.Popen("Rscript --verbose fmr.R", shell=True).wait()
    print("\npython says: 'Yay!! The run was sccessful'")
except:
    print("\npython says: 'Opps! The run was unsccessful'")
