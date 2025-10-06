#!/bin/bash
BLUE='\033[0;34m'
BLUEBG='\033[0;44m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GREY='\033[0;37m'
WHITE='\033[1;37m'
NOCOLOR='\033[0m' 
echo -e -n "Text output: ${RED}red${NOCOLOR} "
echo -e "and ${BLUE}blue${NOCOLOR}"
echo -e "neutral $CYAN cyan $NOCOLOR neutral";
echo -e "neutral $GREY grey $NOCOLOR neutral";
echo -e "neutral $BLUEBG$WHITE white text on blue background $NOCOLOR neutral";
