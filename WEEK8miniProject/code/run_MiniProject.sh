#!/bin/bash
# Author: Y_Sun_ys219@ic.ac.uk
# Script: run_MiniProject.sh
# Date: Mar 2020

echo "Running Yige's Miniproject @ " `date`

start=$(date +%s)
hashline="#############################"
endmsg=$"\n Done!"

echo "MUST BE RUN IN code/ directory"

Rscript 01_intro_plots.R

echo $hashline
echo "Fitting models"
echo $hashline

python3 02_model_fitting.py

echo $endmag


echo $hashline
echo "Handling Outputs"
echo $hashline

Rscript 03_fitting_result.R

echo $endmsg


echo $hashline
echo "Doing Analysis"
echo $hashline

Rscript 04_analysis.R




echo $hashline
echo "Compiling report"
echo $hashline
## latex


texcount -1 -sum 05_writeup.tex > 05_writeup.sum 
pdflatex 05_writeup.tex
pdflatex 05_writeup.tex
bibtex 05_writeup
pdflatex 05_writeup.tex 
pdflatex 05_writeup.tex
mv 05_writeup.pdf ../results

wait

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.sum
rm *.bbl
rm *.blg
rm *.fls
rm *.fdb*
rm *.gz
rm *.pdf

Rscript 06_supplementary_plots.R