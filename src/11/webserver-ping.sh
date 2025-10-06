#!/bin/bash
# usage: this script measures the download time
# for the base page of a website and logs it to 
# LOGFILE; LOGFILE and TMPFILE must be writeable
# by the account which executes this script!


# english language settings (esp. for curl and date)
LANG=
# host to monitor
HOST=example.com
# log file
LOGFILE=/var/log/$HOST-ping-time.log
# temporary file for error messages (i.e. connection timeout)
TMPFILE=/tmp/curl.error

# timeout 2 sec
# -s: silent
# -S: but output error
# -w: output time
# -o: redirect downloaded file to /dev/null
# 2>: redirect stderr to /tmp/curl.error
time=$(curl --connect-timeout 2 -s -S -w '%{time_total}\n' \
       -o /dev/null  2> $TMPFILE \
       https://$HOST)

if [ $? -ne 0 ]; then
  # output is sent per mail if script is
  # run by cron on a Linux system with mail server
  cat $TMPFILE
else
  now=$(date)
  echo "$time sec @ $now" >> $LOGFILE
fi

