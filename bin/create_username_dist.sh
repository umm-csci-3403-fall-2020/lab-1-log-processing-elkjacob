#!bin/bash

#move to directory
cd ./"$1"
#gather contents of failed_login_data.txt into
cat /{}/failed_login_data.txt > tmp_data.txt
#sort input with 'sort'
sort tmp_data.txt
#count how many times each username appears with command 'uniq'
#'awk' command that converts output of 'uniq' into desired 'data.addRow'
#dump into 'tmp_file.txt' and pass to 'wrap_contents.sh'
