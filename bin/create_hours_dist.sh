#!/usr/bin/env bash

#Move to directory
cd ./"$1" || exit

#Create the hours_dist.html file
touch hours_dist.html

#Gather the contents of every failed_login_data.txt file and put it into tmp_data.txt
find . -type f -name 'failed_login_data.txt' -exec cat {} + > tmp_data.txt

#Sort tmp_data.txt
sort tmp_data.txt

#Takes in tmp_data.txt and then filters out everything except hours and puts it in hours_dist.html
awk -F"[ :]+" '/.*/ {print $3}'< ./tmp_data.txt > hours_dist.html

#Sort hours and put the output in tmp_data.txt
sort -n hours_dist.html > tmp_data.txt

#Count how many times each hour appears with command uniq and pipes it
#into awk, where it prints data.addRow(['hour', repetitions]) into hours_dist.html
uniq -c tmp_data.txt | awk '/.*/ {print "data.addRow([\x27"$2"\x27, "$1"]);"}' > hours_dist.html

#Change directory to the top level
cd ..

#Take the contents of hours_dist.html and pass it through wrap_contents.sh into tmp_data.txt
./bin/wrap_contents.sh ./data/hours_dist.html ./html_components/hours_dist ./data/tmp_data.txt

#Write the final wrapped content to hours_dist.html
cat ./data/tmp_data.txt > ./data/hours_dist.html
