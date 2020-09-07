tmp_dir=$(mktemp -d)
#Loop over tar files and extract contents
for i in "$@"
do
base_file_name=$(awk '/(-w\)_secure.tgz/')
tar -xzf ./log_files/"$i" -C "$tmp_dir"/"base_file_name"
#Call 'process_client_logs.sh'
./bin/process_client_logs.sh ./"tmp_dir"/"$base_file_name"
done
#Call 'create_username_dist.sh'
./bin/create_username_dist.sh "$tmp_dir"
#Call 'create_hours_dist.sh'
./bin/create_hours_dist.sh "$tmp_dir"
#Call 'create_country_dist.sh'
./bin/create_country_dist.sh "$tmp_dir"
#Calls 'assemble_report.sh'
./bin/assemble_report.sh "$tmp_dir"
#Move resulting 'failed_login_summary.html' to directory where process_logs.sh was called.
mv failed_login_summary.html /"$here"

#cleanup, rm temporary directory
rm "$tmp_dir"
