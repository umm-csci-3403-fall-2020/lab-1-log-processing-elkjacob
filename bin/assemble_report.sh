#!/usr/bin/env bash

#Change directory
cd "$1" || exit

#Create content and failed_login_summary
touch content.html
touch failed_login_summary.html

#Merges all three .html files into one file
cat ./country_dist.html ./hours_dist.html ./username_dist.html > content.html

#Uses wrap_contents.sh to wrap the header and footer around failed_login_summary
../bin/wrap_contents.sh ./content.html ../html_components/summary_plots ./failed_login_summary.html

