#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk
# Script: align_seqs_fasta.py
# Desc: Two example sequences to match,it takes two sequences from two fasta sequence files and save the best match to alignment output
# Arguments: 2
# Input:ipython3 align_seqs_fasta.py <fasta1><fasta2>
# Output: ../results/alignment_fasta_output.txt; best match printed in python terminal
# Date: Oct 2019
"""Two example sequences to match,it takes two sequences from two fasta sequence files
and save the best match to alignment output """
import sys


if len(sys.argv) == 3:
    with open(sys.argv[1],'r') as fasta_file1:
        seq1 = ""
        headerline = True
        for row in fasta_file1:
            if headerline:
                headerline = False
            else:
                seq1 = seq1 + row.strip("\n")
    
    with open(sys.argv[2],'r') as fasta_file2:
        seq2 = ""
        headerline = True
        for row in fasta_file2:
            if headerline:
                headerline = False
            else:
                seq2 = seq2 + row.strip("\n")# Load seq2

else:
    with open("../data/407228326.fasta",'r') as fasta_file1:
        seq1 = ""
        headerline = True
        for row in fasta_file1:
            if headerline:
                headerline = False
            else:
                seq1 = seq1 + row.strip("\n")
    
    
    with open("../data/407228412.fasta",'r') as fasta_file2:
        seq2 = ""
        headerline = True
        for row in fasta_file2:
            if headerline:
                headerline = False
            else:
                seq2 = seq2 + row.strip("\n")# Load seq2

# Two example sequences to match

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """work out the best match"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    # print("." * startpoint + matched)           
    # print("." * startpoint + s2)
    # print(s1)
    # print(score) 
    # print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 

def main(argv):
    """main function"""
    print(my_best_align)
    print(s1)
    print("Best score:", my_best_score)
    f = open('../results/alignment_fasta_output.txt','w')
    f.write(my_best_align + "\n"+s1+"\n"+"Best score:"+ str(my_best_score)) ## Add a new line at the end
    f.close()

if (__name__ == "__main__"):
    status =main(sys.argv)
    sys.exit(status)

