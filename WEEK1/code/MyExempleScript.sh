#!/bin/bash

# Author: Y_Sun_ys219@ic.ac.uk
# Script: MyExampleScript.sh
# Desc: print a greeting line in two ways
# Arguments: 0
# Input: MyExampleScript.sh
# Output: two lines of greeting messages with user name
# Date: Oct 2019

msg1="Hello"
msg2=$USER
echo "$msg1 $msg2"
echo "Hello $USER"
echo
