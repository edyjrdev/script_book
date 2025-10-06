#!/bin/bash

# usage: execute the commands in select.sql for all databases listet in dbs.txt

# requirements: MySQL or MariaDB server running on localhost with databases listed in dbs.txt
#               current user can access these databases (password data in ~/.my.cnf)
#               tables of these databases match the commands in select.sql

# file with database names
DBLIST=dbs.txt

# file with SELECT commands to run
SQLFILE=select.sql


for db in $(cat $DBLIST | sort) ; do
  echo "Database: $db"
  mysql $db < $SQLFILE
  echo "---"
done
