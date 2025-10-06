#!/bin/bash
# creates directory like 2023-12 and moves photos
# passed as arguments into the corresponding directory
#
# usage: ./sort-photos.sh file1.jpg file2.jpeg ...
#
# requirement: exiftool

# loop over passed arguments
for file in "$@"; do
    yearmonth=$(exiftool -s3 -d '%Y-%m' -DateTimeOriginal $file)
    if [ $yearmonth ]; then
        echo "$file -> $yearmonth/"
        mkdir -p $yearmonth
        mv "$file" $yearmonth/
    fi
done
