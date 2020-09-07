#!/usr/bin/env bash

#Move to directory
cd ./"$1" || exit

#Create the country_dist.html file
touch country_dist.html

#Gather the contents of every failed_login_data.txt file and put it into tmp_data.txt
find . -type f -name 'failed_login_data.txt' -exec cat {} + > tmp1_data.txt

#Takes in tmp_data.txt and then filters out everything except the IP addresses and puts it in country_dist.html
awk -F"[ :]+" '/.*/ {print $5}'< ./tmp1_data.txt > tmp2_data.txt

#Sort IP addresses
sort -nr tmp2_data.txt > tmp3_data.txt

#Sort the IP country map
#sort -k 2 ../etc/country_IP_map.txt

#Join IP map data with the sorted IP addresses
join tmp3_data.txt ../etc/country_IP_map.txt > tmp4_data.txt

#Sort by country
#sort -k 2 tmp4_data.txt > tmp5_data.txt

#Count how many times each country appears with command uniq and pipes it
#into awk, where it prints data.addRow(['country', repetitions]) into country_dist.html
#uniq -c tmp5_data.txt | awk '/.*/ {print "data.addRow([\x27"$2"\x27, "$1"]);"}' > tmp6_data.txt

#Change directory to the top level
#cd ..

#Take the contents of tmp_data.txt and pass it through wrap_contents.sh into hours_dist.html
#./bin/wrap_contents.sh ./data/hours_dist.html ./html_components/hours_dist ./data/tmp_data.txt

#Write the final wrapped content to hours_dist.html
#cat ./data/tmp_data.txt > ./data/hours_dist.html
