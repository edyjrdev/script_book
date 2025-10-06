#!/usr/bin/env pwsh

# this scripts converts all PNGs in the local directory
# to EPS files (encapsulated postscript)
# requirements: ImageMagick

$pngfiles = Get-ChildItem *.png 
foreach ($pngfile in $pngfiles) {
    $pngname = $pngfile.Name
    $epsname = $pngname -replace ".png", ".eps"
    if ((Test-Path $epsname) -and 
        (Get-ChildItem $epsname).LastWriteTime -gt $pngfile.LastWriteTime) 
    {
        continue
    }
    Write-Host "$pngname -> $epsname"
    magick $pngname -quiet -background white -flatten eps2:$epsname
}
