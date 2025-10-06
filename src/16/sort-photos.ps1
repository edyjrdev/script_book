#!/usr/bin/env pwsh

# creates directory like 2023-12 and moves photos
# passed as arguments into the corresponding directory
#
# usage: .\sort-photos.ps1 file1.jpg file2.jpeg ...
#
# requirement: exiftool

# loop over passed arguments
foreach ($arg in $args) {
    # loop over files (Get-Item expands *.jpg to list of files)
    foreach ($file in Get-Item $arg) {
        $yearmonth = exiftool -s3 -d '%Y-%m' -DateTimeOriginal $file
        if ($yearmonth) {
            Write-Output "$($file.Name) -> $yearmonth/"
            $targetdir = New-Item -ItemType Directory -Path $yearmonth -Force 
            Move-Item $file $targetdir
        }
    }
}