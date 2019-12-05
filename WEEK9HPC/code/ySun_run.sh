#!/bin/bash
#PBS -l walltime=00:10:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
##cp code/ySun_HPC_2019_main.R $TMPDIR
R --vanilla < $HOME/code/ySun_HPC_2019_cluster.R
###mv cluster_run_seed_* $HOME
echo "R has finished running"
