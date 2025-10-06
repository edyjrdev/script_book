#!/usr/bin/env pwsh
# makes zipped backups of all databases in directory
# requires SqlServer module (Install-Module SqlServer)
$instance = "localhost\SQLEXPRESS01"
$backupdir = "C:\sqlserver-backups"
$exclude = "tempdb", "other", "tmp"

# create backup directory if it does not exist
New-Item -ItemType Directory -Force $backupdir | Out-Null

$dbs = Get-SqlDatabase -ServerInstance $instance
foreach($db in $dbs) {
    # skip databases listed in $exclude
    if ($db.name -in $exclude) { continue }

    # backup and archive file name
    $backupname = "$backupdir\$($db.name).bak"
    $archivename = "$backupdir\$($db.name).zip"
    Write-Output "Backup database $($db.name) to $archivename"
    
    # backup, create archive (-Force to overwrite existing), 
    # delete original backup file
    Backup-SqlDatabase -ServerInstance $instance `
      -Database $db.name -BackupFile $backupname 
    Compress-Archive -Force $backupname $archivename 
    Remove-Item $backupname
}