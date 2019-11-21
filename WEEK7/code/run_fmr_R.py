import subprocess
try:
    subprocess.Popen("Rscript --verbose fmr.R", shell=True).wait()
    print("Yay!! The run was sccessful")
except:
    print("Opps! The run was unsccessful")
