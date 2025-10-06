#!/usr/bin/env pwsh

# script to sync a number of local directories
# to an other volume 

# name of backup volume (i.e. on USB disk)
$destvolume = "mybackupdisk"

# directories on backup volume
$destdir = "backup-kofler"
$logdir  = "$destdir\sync-logging"

# directories to sync (relative to user directory)
$syncdirs = "Documents", "Pictures", "myscripts"

# note: Get-Volume shows FriendlyName, but the property
#       is actually named FileSystemLabel (?!)
$disk = Get-Volume | Where-Object { $_.FileSystemLabel -eq $destvolume }
if (! $disk) {
    Write-Output "Backup disk $destvolume not found. Exit."
    Exit 1
} 
$drive = ($disk | Select-Object -First 1).DriveLetter
Write-Output "Syncing with disk ${drive}:"

# create destination if it does not exist
New-Item -ItemType Directory -Force "${drive}:\${destdir}" | Out-Null 

# create logging directory and logging file
New-Item -ItemType Directory -Force "${drive}:\${logdir}" | Out-Null 
$logfile = "${drive}:\${logdir}\report-{0:yyyy-MM-dd--HH-mm}.log" -f (Get-Date)
New-Item $logfile | Out-Null 

# loop over directories
foreach ($dir in $syncdirs) {
    $from = "${HOME}\$dir"
    $to = "${drive}:\${destdir}\$dir"
    Write-Output "sync from $from to $to" 
    robocopy /e /purge /xo /log+:$logfile "$from" "$to" 
}
