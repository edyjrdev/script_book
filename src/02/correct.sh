#!/bin/bash
# usage: ./correct.sh *.md

# applies find and replace operations from 
# corrections.txt to all files passed as arguments

# build sed command
sedcmd=""
while read -r findtxt replacetxt; do
    sedcmd+="s/$findtxt/$replacetxt/g;"
done < corrections.txt

# apply sed to all files passed as arguments
for filename in $*; do
    echo "Correct file $filename"
    sed -i.bak "$sedcmd" $filename
done
