#!/bin/bash
# Author: Y_Sun_ys219@ic.ac.uk
# Script: CompileLaTeX.sh
# Desc: compile Latex file
# Arguments: 1
# Input: CompileLaTeX.sh <FirstExample.tex>
# Output: <FirstExample.pdf> in data directory
# Date: Oct 2019

if [-z $1]
    then
    echo "NO INPUT FILE, THE END"
    exit
fi

pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
mv $1.pdf ../data
evince ../data/$1.pdf &

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.bbl
rm *.fls
rm *.blg

exit