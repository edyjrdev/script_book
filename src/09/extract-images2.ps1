#!/usr/bin/env pwsh
# usage: .\extract-images2 file1.md file2.md 
# returns FileInfo objects

Param([string[]]$markdownfiles)

$pattern = '\]\((images-\w+[\/\\]\w+\.(png|jpg|jpeg))\)'
# $pattern = '\]\((bilder[\/\\][\w-]+\.(png|jpg|jpeg))\)'
# loop through each file provided as an argument
foreach ($file in $markdownfiles) {
    # find patterns, loop over results and 
    # output content of pattern group as string
    Select-String $pattern $file |  
      ForEach-Object { 
        Get-ChildItem $_.Matches.Groups[1].Value }
}
