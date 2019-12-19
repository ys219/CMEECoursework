#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
# cp code/ySun_HPC_2019_main.R $TMPDIR 
# tried, can be copied it but couldn't be sourced
# also tried to put all script in $HOME, couldn't be soured, so I copy and poaste all the functions to cluster script
R --vanilla < $HOME/ySun_HPC_2019_cluster.R
mv cluster_run_seed_* $HOME/results
echo "R has finished running"
