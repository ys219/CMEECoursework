#!/bin/env python3

_appname_="usingos"
_author_="ys"
_version_="0.0.1"
_license_="code.program"

"""some tasks to complete"""


# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import re

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")
# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):  
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'
# Type your code here:
    FilesDirsStartingWithC.extend(re.findall(r'/[Cc]\w*/',str(dir)))
    FilesDirsStartingWithC.extend(re.findall(r'/[Cc]\w*/',str(subdir)))
    FilesDirsStartingWithC.extend(re.findall(r'/[Cc]\w*\W\w*/',str(files)))


FilesDirsStartingWithC=set(FilesDirsStartingWithC)
print(FilesDirsStartingWithC)
#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
HomeDirWithC=[]
for (dir, subdir, files) in subprocess.os.walk(home):  
    HomeDirWithC.extend(re.findall(r'home/[Cc]\w*/',str(dir)))


HomeDirWithC=set(HomeDirWithC)
print(HomeDirWithC)