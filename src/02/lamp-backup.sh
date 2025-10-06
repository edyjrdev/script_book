#!/bin/bash
dbfile="/localbackup/sql.gz"
mysqldump -u backupuser --single-transaction dbname | \
  gzip -c > $dbfile
htmlfile="/localbackup/html.tar.gz"
tar czf $htmlfile -C /var/www/html/applicationdir .
