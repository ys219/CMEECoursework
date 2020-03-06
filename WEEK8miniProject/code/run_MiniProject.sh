echo "Running Yige's Miniproject @ " `date`

start = $(date +%s)
hashline = "#############################"
endmsg = "\n Done!"

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

echo $endmsg


