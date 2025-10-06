#!/bin/bash
# sample file myoptions.sh
echo "Parameters before getopts: $*"

while getopts ":ab:c:" opt; do
    case $opt in
       a) echo "Option a";;
       b) echo "Option b with parameter $OPTARG";;
       c) echo "Option c with parameter $OPTARG";;
       ?) echo "Invalid option"
          echo "Usage: myoptions [-a] [-b data] [-c data] [...]"
          exit 2
          ;;
    esac
done
# remove processed options from $*
echo "OPTIND=$OPTIND"
echo "Parameters before shift: $*"
shift $(( $OPTIND - 1 ))
echo "More parameters: $*"
