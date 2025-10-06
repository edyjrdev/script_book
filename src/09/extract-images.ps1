#!/usr/bin/env pwsh
# usage: .\extract-images file1.md file2.md [> images.txt]
# returns strings

Param([string[]]$markdownfiles)

$pattern = '\]\((images-\w+[\/\\][\w-]+\.(png|jpg|jpeg))\)'
# loop through each file provided as an argument
foreach ($file in $markdownfiles) {
    # find patterns, loop over results and 
    # output content of pattern group as string
    Select-String $pattern $file |  
      ForEach-Object { $_.Matches.Groups[1].Value }
}
