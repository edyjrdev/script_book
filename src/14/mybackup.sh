#!/bin/bash
# this code fragment does NOT actually make 
# a backup; it only shows a save way to save
# configuration settings and passwords outside 
# the code file

# import settings
. mybackup.conf

# mysqldump liest das Passwort aus .my.cnf
mysqldump -u $MYSQLUSER $DBNAM > db.sql

# lftp liest das Passwort aus .netrc
lftp $FTPHOST << EOF
cd remote/dir/ 
put db.sql
bye
EOF

