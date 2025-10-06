#!/bin/bash
# usage: creates PDFs for each *.md file
#        stop with Ctrl+C
#        requirement: Pandoc installation
while true; do
    for mdfile in *.md; do
        pdffile=${mdfile%.md}.pdf
        if [ $mdfile -nt $pdffile ]; then
            echo $mdfile
            pandoc $mdfile -o $pdffile
        fi
    done
    sleep 1
done
