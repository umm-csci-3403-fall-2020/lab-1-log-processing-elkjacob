#!/usr/bin/env bash

# Capture the directory to be worked in and the current directory
# Change directory to the given directory from the command line
client_dir=$1
here=$(pwd)
cd "$client_dir" || exit

# Create failed_login_data.txt
touch failed_login_data.txt

# Takes in all log files and then finds the info for invalid users and puts it in failed_login_data.txt
cat ./var/log/* | awk -F"[ :]+" '/Failed password for invalid user/ {print $1,$2,$3,$13,$15}'>> failed_login_data.txt

# Takes in all log files and then finds the info for vaild users and puts it in failed_login_data.txt
cat ./var/log/* | awk -F"[ :]+" '/Failed password for/ && !/invalid/ {print $1,$2,$3,$11,$13}' >> failed_login_data.txt

# Change back to the original directory
cd "$here" || exit

