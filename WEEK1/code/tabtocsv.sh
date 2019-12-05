#!/bin/bash
# Author: Y_Sun_ys219@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas and Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Input: tabtocsv.sh <txt file with tabs>
# Output: save the output file into a .csv
# Date: Oct 2019

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
exit