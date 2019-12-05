#!/bin/bash

# Author: Y_Sun_ys219@ic.ac.uk
# Script: ConcatenateTwoFile.sh
# Desc: merge two files into one file
# Arguments: 1
# Input: ConcatenateTwoFile.sh <file1><file2><outputfile>
# Output: save the <outputfile> and print the output file contents
# Date: Oct 2019
cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3
##adding two input file to a new file and print the new file