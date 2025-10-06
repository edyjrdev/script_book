#!/usr/bin/env pwsh
# This example requires a correctly configured
# remote server and SSH keys to run scp without
# login. See the SSH chapter in the book.
$localdir = (Get-Location).Path
$remotedir = "/var/www/html/wordpress/myimages"
$remotehost = "hostname"
$remoteuser = "username"
$lastrun = "$localdir/last-run"
$now = "$localdir/now"

# create last-run file if it does not exist;
# use an old date (2000-01-01)
if (-not (Test-Path $lastrun)) {
    (New-Item $lastrun).LastWriteTime = Get-Date "2000-01-02"
}

# create file with current date
New-Item $now -Force | Out-Null

# upload all files changed after last-run
$session = New-PSSession $remotehost -Username $remoteuser
$lastruntime = (Get-Item $lastrun).LastWriteTime
Get-ChildItem -Path $localdir/* `
    -Include "*.jpg", "*.jpeg", "*.png" | 
  Where-Object { $_.LastWriteTime -gt $lastruntime } | 
  ForEach-Object { 
    Copy-Item -ToSession $session $_ $remotedir
  }
Remove-PSSession $session

# update last-run
Move-Item -Force $now $lastrun 