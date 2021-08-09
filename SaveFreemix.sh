#!/bin/bash

for i in /home/mansi/projects/rrg-vmooser/mansi/Covid_Biobank/BQC*.sorted.dup.recal.prefix.selfSM; do
        awk 'FNR == 2 {print $1}' "$i" >> test1.txt
        awk 'FNR == 2 {print $7}' "$i" >> test2.txt
done
