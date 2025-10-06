#!/bin/bash
# gets average ping time
# usage: ./ping-avg.sh <hostname1> <hostname2> ...
if [ $# -lt 1 ]; then 
  echo "usage: ./ping-avg.sh <hostnames>"
  exit 2
fi
for hostname in $*; do
  avg=$(ping -c 4 $hostname | cut -s -d '/' -f 5)
  echo "Average ping time for $hostname is $avg ms"
done
