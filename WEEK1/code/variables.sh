#!/bin/bash

# Author: Y_Sun_ys219@ic.ac.uk
# Script: variables.sh
# Desc: examples of assign values to variables
# Arguments: 0
# Date: Oct 2019

# Shows the use of variables
MyVar='some string'
echo 'the current value of the variable is' $MyVar
echo 'Please enter a new string'
read MyVar
echo 'the current value of the variable is' $MyVar

## Reading multiple values
echo 'Enter two numbers separated by space(s)'
read a b
echo 'you entered' $a 'and' $b '. Their sum is:'
mysum=`expr $a + $b`
echo $mysum