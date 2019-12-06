#!/bin/env python3


"""profiling and export outputs"""

# __appname__=="TestR"
# __author__=="YSun"
# __version__=="0.01"
# __liscence__=="code.program"

import subprocess

subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait()

subprocess.Popen("Rscript --verbose NonExistScript.R > ../results/outputFile.Rout 2> ../results/errorFile.Rout", shell=True).wait()
##complile R and save the outcomes