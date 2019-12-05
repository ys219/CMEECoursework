#!/bin/bash
touch $1/TESTRM.md

echo -e "CMEECoursework $1\n==\nby Yige Sun,  MRes.CMEE,  2019-20" > TESTRM.md

for i in `ls $1/*|grep -v "bib\|txt\|pyc\|cpy*\|^$\|log\|pdf\|synctex\|ance.tex"`;do
## Script title & Function\
    echo "" >> ../TESTRM.md
	echo -e "### ${i}\n" >> ../TESTRM.md
	echo -e "##### Description:\n" >> ../TESTRM.md
	grep "Desc:" ${i}|cut -f 2 -d ":"|sed -e "s/ //1" >> ../TESTRM.md

	## Script Sample Input
	echo "" >> ../TESTRM.md
	echo -e "#### input example\n " >> ../TESTRM.md
	echo "````" >> ../TESTRM.md
	grep "Input" ${i}|cut -f 2 -d ":"|sed -e "s/ //1" >> ../TESTRM.md
	echo "````" >> ../TESTRM.md

	## Script Sample Output
	echo "" >> ../TESTRM.md
	echo "#### Output" >> ../TESTRM.md
	echo "" >> ../TESTRM.md
	grep "Output" ${i}|cut -f 2 -d ":"|sed -e "s/ //1" >> ../TESTRM.md

	echo "*****" >> ../TESTRM.md
done
