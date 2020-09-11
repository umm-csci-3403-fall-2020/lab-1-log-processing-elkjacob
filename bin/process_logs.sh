#!/usr/bin/env bash

#Store the current directory and create a temporary directory named 'data'
here=$(pwd)
mkdir data

#Loop over the log files, create a directory named after the log,
#and extract the contents of the log into that directory
for name in cscirepo_secure.tgz discovery_secure.tgz ganesha_secure.tgz mylar_secure.tgz velcro_secure.tgz zeus_secure.tgz
do
        base=$(basename "$name" _secure.tgz)
        mkdir ./data/"$base"
        tar -xzf ./log_files/"$name" -C ./data/"$base"

        #Call 'process_client_logs.sh'
        ./bin/process_client_logs.sh ./data/"$base"
done

#Call the scripts
./bin/create_username_dist.sh data
./bin/create_hours_dist.sh data
./bin/create_country_dist.sh data
./bin/assemble_report.sh data

#Move resulting 'failed_login_summary.html' to directory where process_logs.sh was called.
mv ./data/failed_login_summary.html "$here"

#Cleanup, remove temporary directory
rm -rf ./data
