#!/bin/bash

#there is a problem with the tipe of files we have. The comma in the name fields are read as new fields
#we use csvkit to convert the file to tsv, so that commas will appear only when used as name separator

csvformat -T hero-network.csv > hero2.tsv

#Task 1: What is the most popular pair of heroes (often appearing together in the comics)?
awk -F "\t" '$1!=$2' hero2.tsv | sort | uniq -c > couples.txt
echo 'the most popular couple is: ' 

sort -k 1 -n -r < couples.txt | head -1

#Task 2: Number of comics per hero
echo number of comics per hero
cut -d "," -f 1 edges.csv | sed "s/[^A-Za-z]//g" | uniq -c | sort -k 1

#Task 3: The average number of heroes in comics
echo 'the average number of heroes in comics is: '
awk '{sum[$1]+=$2;count[$1]++;}END{for(i in sum)print i", "sum[i]/count[i];}' edges.csv
#https://www.reddit.com/r/bash/comments/8qlfrr/group_by_and_average_using_bash/