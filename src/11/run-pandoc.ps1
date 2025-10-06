#!/usr/bin/env pwsh
# usage: creates PDFs for each *.md file
#        stop with Ctrl+C
#        requirement: Pandoc installation
while($true) {
    foreach($mdfile in Get-ChildItem -Path *.md) {
        $pdffile = $mdfile.FullName.Replace(".md", ".pdf")
        if(!(Test-Path $pdffile) -or 
            ($mdfile.LastWriteTimeUtc -gt 
             (Get-Item $pdffile).LastWriteTimeUtc)) 
        {
            Write-Host $mdfile.Name
            # change path here
            C:\path\to\pandoc.exe $mdfile.FullName -o $pdffile
        }
    }
    Start-Sleep -Seconds 1
}