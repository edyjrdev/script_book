# $NoOfFiles specifies how many files should be deleted (default: 10)
param(
  [int] $NoOfFiles = 10
)

Set-StrictMode -Version 3.0

# DownPath contains the Downloads directory
$DownPath = (New-Object -ComObject Shell.Application). `
               NameSpace('shell:Downloads').Self.Path

$DownPath
	       
# find largest files in Downloads directory and
# ask to delete them
Get-ChildItem -Path $DownPath | 
     Sort-Object -Property Length -Descending | 
     Select-Object -First $NoOfFiles | 
     Remove-Item -Confirm
