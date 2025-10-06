#!/bin/bash
# save contents of this directory
documentdir=~/Dokumente
# use this directory to save backups
backupdir=~/mybackups
# creates backup directory if necessary
mkdir -p $backupdir
# i. e. date=27 for 2023-03-27
day=$(date '+%d')
# create backup, save as 'documents-<day>.tar.gz'
echo "Backup file: $backupdir/documents-$day.tar.gz"
tar czf $backupdir/documents-$day.tar.gz -C $documentdir .
