#!/bin/bash

# script to sync a number of local directories
# to an other volume 

# mount point of backup volume (i.e. on USB disk)
DESTVOLUME="/run/media/kofler/mybackupdisk"

# directories on backup volume
DESTDIR="backup-kofler"
LOGDIR="$DESTDIR/sync-logging"

# directories to sync (relative to home directory)
# don't separate entries with ','!
SYNCDIRS=("Documents" "Pictures" "myscripts")

# test is backup volume is available
if ! mount | grep $DESTVOLUME --quiet; then
    echo "Backup disk $DESTVOLUME not found. Exit."
    exit 1
fi

# create destination and logging directory if they do not exist
mkdir -p "$DESTVOLUME/$DESTDIR"
mkdir -p "$DESTVOLUME/$LOGDIR"

# setup logging file name
logfname=$(date "+rsycn-%Y-%m-%d--%H-%M.log")
log="$DESTVOLUME/$LOGDIR/$logfname"

# loop over sync dirs
for dir in "${SYNCDIRS[@]}"; do
    from=$HOME/$dir
    to=$DESTVOLUME/$DESTDIR/$dir
    echo "sync from $from to $to"
    rsync -a --delete -v "$from" "$to" >> $log
done