#!/bin/bash

hashline="#################################################################"
##NOTE:bash run in the directory where data folders stored(mbc/ or sandbox/)
## this code has been editted from primer removal -> pair merging script, original codes were commented
 
echo $hashline 
echo "This is the START of Read Processing" `date` 

# mkdir 01_trimmed 02_merged #create directories to store data

mkdir 01_merged 02_trimmed 

output=../output_log.txt #where to store the ouput logs

START=$(date +%s) #timming tool to record the running time
echo $hashline 
echo "check No. reads in 0_demux @ " `date` 
echo $hashline 

grep -c "^@" 0_demux/*.fq 

echo $hashline 
# echo "STEP1_Primer_Removal @ " `date` 
echo "STEP1_Pair_Merging @ " `date` 
echo $hashline  



while read f; do pear -f 0_demux/${f}_R1.fq -r 0_demux/${f}_R2.fq -o 01_merged/${f} -q 26 -v 100 & done < <(ls 0_demux | rev | cut -d_ -f2- | rev | sort | uniq) # & before done make it parallel



wait ## ensure all the parallel commands finished then do the next step
echo $hashline 
# echo "check No. reads in 01_trimmed @ " `date`
echo "check No. reads in 01_merged @ " `date`
echo $hashline 

 


rm 01_merged/*discarded* 01_merged/*unassembled* && rename -e "s/assembled\.//" 01_merged/*

grep -c "^@" 01_merged/*
NOW1=$(date +%s)
echo $hashline
echo "STEP1_Pair_merging took $(($NOW1 - $START))s" 
echo $hashline 
echo "STEP2_Primer_removal @ " `date` 
echo $hashline 



while read f; do cutadapt -j 10 -g CCNGAYATRGCNTTYCCNCG...TGRTTYTTYGGNCAYCCNGARGTNTA -o 02_trimmed/${f} --discard-untrimmed 01_merged/${f}; done < <(ls 01_merged) 


wait 
echo $hashline 
echo "check No. reads in 02_primer_removal @ " `date` 
echo $hashline 

grep -c "^@" 02_trimmed/* 


NOW2=$(date +%s)
echo $hashline 
echo "STEP2_Primer_Removal took $(($NOW2 - $NOW1))s" 
echo $hashline


echo $hashline 
echo "This is the END of Read Processing" `date` 
echo $hashline 

END=$(date +%s)
echo "Read Processing took $(($END - $START))s" 
echo $hashline 

