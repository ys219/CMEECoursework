#!/bin/bash

# Author: Y_Sun_ys219@ic.ac.uk
# Script: CountLines.sh
# Desc: count the number of lines of input file
# Arguments: 1
# Input: CountLines.sh <inputfile>
# Output: number of line shown on terminals
# Date: Oct 2019

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo