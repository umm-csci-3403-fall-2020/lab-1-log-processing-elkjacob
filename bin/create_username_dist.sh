#!/usr/bin/env bash

#Move to directory
cd "$1" || exit

#Create the username_dist.html file
touch username_dist.html

#Gather the contents of every failed_login_data.txt file and put it into tmp_data.txt
find . -type f -name 'failed_login_data.txt' -exec cat {} + > tmp_data.txt

#Sort input with sort
sort tmp_data.txt

#Takes in tmp_data.txt and then filters out everything except usernames and puts it in username_dist.html
awk -F"[ :]+" '/.*/ {print $4}'< ./tmp_data.txt > username_dist.html

#Sort usernames
sort username_dist.html > tmp_data.txt

#Count how many times each username appears with command uniq and pipes it
#into awk, where it prints data.addRow(['username', repetitions]) into username_dist.html
uniq -c tmp_data.txt | awk '/.*/ {print "data.addRow([\x27"$2"\x27, "$1"]);"}' > username_dist.html

#Change directory to the top level
cd ..

#Take the contents of username_dist.html and pass it through wrap_contents.sh into tmp_data.txt
/bin/wrap_contents.sh ./data/username_dist.html ./html_components/username_dist ./data/tmp_data.txt

#Write the final wrapped content to username_dist.html
cat ./data/tmp_data.txt > ./data/username_dist.html
