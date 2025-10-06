#!/bin/bash

# script expects two parameters
if [ $# -ne 2 ]; then 
  echo "Usage:   get-energy-consumption <countrycode> <year>"
  echo "Example: get-energy-consumption FRA 2021"  
  exit 2
fi

# download file if not yet locally saved
if [ ! -f owid-energy-data.csv ]; then
  wget https://nyc3.digitaloceanspaces.com/owid-public/data/energy/owid-energy-data.csv
fi


# remove not needed columns, filter lines, 
# use last line if result has more than one line
data=$(cut -d ',' -f 1,2,3,32 owid-energy-data.csv | grep $1 | grep $2 | tail -n 1)

# extract items from result
country=$(echo $data | cut -d ',' -f 1)
year=$(echo $data | cut -d ',' -f 2)
energy=$(echo $data | cut  -d ',' -f 4)

# output result
if [ "$country" ] && [ "$energy" ]; then
  echo -n "Primary energy consumption per person "
  echo "for $country in $year: $energy kWh/a"
else
  echo "Sorry, no data found for $1 $2."
fi


