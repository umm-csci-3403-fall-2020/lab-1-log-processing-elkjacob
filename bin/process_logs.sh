#!/usr/bin/env bash
here=$(pwd)
DIR="$(cd "$(dirname "$0")" && pwd)"
tmp_dir=$(mktemp -d)
#Loop over tar files and extract contents
for i in "$@"
do
awk 'match($0, /(\w)_secure.tgz/, group) {base_file_name=group[1]}' "$i"
tar -xzf "$i" -C "$tmp_dir"/"$base_file_name"
#Call 'process_client_logs.sh'
"$DIR"/process_client_logs.sh "$tmp_dir"/"$base_file_name"
done

"$DIR"/create_username_dist.sh "$tmp_dir"
"$DIR"/create_hours_dist.sh "$tmp_dir"
"$DIR"/create_country_dist.sh "$tmp_dir"
"$DIR"/assemble_report.sh "$tmp_dir"
#Move resulting 'failed_login_summary.html' to directory where process_logs.sh was called.
mv failed_login_summary.html /"$here"

#cleanup, rm temporary directory
rmdir "$tmp_dir"
