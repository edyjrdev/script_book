#!/usr/bin/bash
# This example requires a correctly configured
# remote server and SSH keys to run scp without
# login. See the SSH chapter in the book.
LOCALDIR=$(pwd)
REMOTEDIR=/var/www/html/wordpress/myimages
REMOTEHOST=hostname
REMOTEUSER=username
LASTRUN=$LOCALDIR/last-run
NOW=$LOCALDIR/now

# create last-run file if it does not exist;
# use an old date (2000-01-01)
if [ ! -f $LASTRUN ]; then 
  touch -m -t 200001010000 $LASTRUN
fi

# create file with current date
touch $NOW

# upload all files changed after last-run
find $LOCALDIR -maxdepth 1 \( -name "*.jpg" -o -name "*.jpeg" \
   -o -name "*.png" \) -newer $LASTRUN \
   -exec scp {} $REMOTEUSER@$REMOTEHOST:$REMOTEDIR \;
         
# update last-run
mv $NOW $LASTRUN
