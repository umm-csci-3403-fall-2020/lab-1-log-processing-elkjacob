#!/usr/bin/env bash

#Move to directory
cd ./"$1" || exit

#Create the country_dist.html file
touch country_dist.html

#Gather the contents of every failed_login_data.txt file and put it into tmp1_data.txt
find . -type f -name 'failed_login_data.txt' -exec cat {} + > tmp1_data.txt

#Takes in tmp1_data.txt and then filters out everything except the IP addresses and puts it in tmp2_data.txt
awk -F"[ :]+" '/.*/ {print $5}'< ./tmp1_data.txt > tmp2_data.txt

#Sort IP addresses
sort tmp2_data.txt > tmp3_data.txt

#Join IP map data with the filtered IP addresses
join tmp3_data.txt ../etc/country_IP_map.txt > tmp4_data.txt

#Filters out the IP addresses so that only the countries appear
awk '{print $2} '< tmp4_data.txt > tmp5_data.txt

#Sorts the countries
sort tmp5_data.txt > tmp6_data.txt

#Count how many times each country appears with command uniq and pipes it
#into awk, where it prints data.addRow(['country', repetitions]) into tmp7_data.txt
uniq -c tmp6_data.txt | awk '/.*/ {print "data.addRow([\x27"$2"\x27, "$1"]);"}' > tmp7_data.txt

#Change directory to the top level
cd .. || exit

#Take the contents of tmp7_data.txt and passes it through wrap_contents.sh into tmp_final.txt
./bin/wrap_contents.sh ./data/tmp7_data.txt ./html_components/country_dist ./data/tmp_final.txt

#Write the final wrapped content to country_dist.html
cat ./data/tmp_final.txt > ./data/country_dist.html

#Remove all temporary files
rm -f tmp*.txt
