#!/usr/bin/env pwsh

# usage: execute the commands in select.sql for all databases listet in dbs.txt

# requirements: SQL Server server running on localhost with databases listed in dbs.txt
#               current user can access these databases
#               tables in these databases match the commands in select.sql

# file with database names
$dblist = "dbs.txt"

# file with SELECT commands to run
$sqlfile = "select.sql"

# name of SQL Server instance (replace . by hostname if SQL Server is not on localhost)
$server = ".\sqlexpress01"

# loop over all databases
foreach($db in Get-Content $dblist) {
    Write-Output "Database: $db"
    sqlcmd -S $server -d $db -i $sqlfile 
}