#!/bin/bash

# Author: Y_Sun_ys219@ic.ac.uk
# Script: tiff2sh.sh
# Desc: convert tiff to png file
# Arguments: 1
# Input: tiff2png.sh <tif file>
# Output: 
# Date: Oct 2019

for f in *.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).png"; 
    done
    