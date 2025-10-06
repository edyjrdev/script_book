#!/bin/bash
# usage: ./ip-address-statistic.sh file.log

# expects the filename of a log file as single parameter
# extracts the first column; sorts the entries; counts them; 
# sorts again numeric and reverse; shows the top 20 results
cut -d ' ' -f 1 $1 | sort | uniq -c | sort -n -r | head -n 20