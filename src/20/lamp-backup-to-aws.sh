#!/bin/bash

# * backups of MySQL database and a WordPress installation dir
# * makes one backup for each day of weeks; overwrites backups
#   older than one week
# * uploads the backups into an AWS bucket

# requirements:
# * LAMP server
# * aws (see https://aws.amazon.com/cli)
# * gpg (apt install gpg)
# * mysqldump password in /root/.my.cnf
# * key file /etc/mykey for encryption (min. 16 byte)
# * /root/.aws/config and /root/.aws/credentials to get write access in AWS S3 bucket

BACKUPDIR=/localbackup
DB=wp
DBUSER=wpbackupuser
WPDIR=/var/www/html/wordpress
BUCKET=s3://my.bucket.name

function mycrypt {
  gpg -c -q --batch --cipher-algo AES256 --compress-algo none --passphrase-file /etc/mykey
}
function myuncrypt {
  gpg -d --batch --no-tty -q --cipher-algo AES256 --compress-algo none --passphrase-file /etc/mykey
}


# mysql backup
weekday=$(date +%u)
dbfile=$BACKUPDIR/wp-db-$weekday.sql.gz.crypt
mysqlopt='--single-transaction'
mysqldump -u $DBUSER $mysqlopt $DB | gzip -c | mycrypt > $dbfile

# make backup of WordPress installation + uploads
htmlfile=$BACKUPDIR/wp-html-$weekday.tar.gz.crypt
tar czf - -C $WPDIR . | mycrypt > $htmlfile

# upload into AWS bucket
/usr/local/bin/aws s3 cp $dbfile   $BUCKET
/usr/local/bin/aws s3 cp $htmlfile $BUCKET
