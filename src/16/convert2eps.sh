#!/bin/bash
# this scripts converts all PNGs in the local directory
# to EPS files (encapsulated postscript)
# requirements: ImageMagick
for pngfile in *.png; do
    epsfile=${pngfile%.png}.eps
    if [ $pngfile -nt $epsfile ]; then
        echo "$pngfile -> $epsfile"
        magick "$pngfile" -quiet -background white -flatten "eps2:$epsfile"
    fi
done
