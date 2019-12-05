#!/bin/bash
# Author: ys219@imperial.ac.uk
# Script: csvtospace.sh
# Description: substitute the comma in the files with a space
# Saves the output into a *.txt file
# Arguments: 1 -> tab delimited file
# Date: Oct 2019

# Notice: if failed to bash it, try
# bash csvtospace.sh "../data/18*.csv"

echo $1
for file in $1;
    do
        echo -e "Creating a space delimited version of $file ...";
        cat $file | tr -s "," " " >> ../data/$file.txt;
        echo "Done!";
    done