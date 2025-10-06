#!/bin/bash
# sample file convert.sh
# converts all *.png files into JPEG format
# requires convert command (Ubuntu: apt install imagemagick)

# avoids error if there is no *.png file
shopt -s nullglob

# loop over all *.png files
for pngname in *.png; do
    # replaces .png by .jpg
    jpgname=${pngname%.png}.jpg
    echo "$pngname  -->  $jpgname"
    convert "$pngname" "$jpgname" 
done
