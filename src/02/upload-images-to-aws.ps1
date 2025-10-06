#!/usr/bin/env pwsh
# uploads images in the local directory into an AWS S3 bucket
# saves the last run time of the script in 'last-run'

# reqirements: * AWS Tools (Install-Module AWS.Tools.Common, Install-Module AWS.Tools.S3)
#              * AWS bucket (change bucket name in Write-S3Object call!)
#              * AWS credentials to access bucket (run Set-AWSCredential ... -StoreAs MyProfile)

if (Test-Path -Path "last-run") {
    $lastRunTime = (Get-Item -Path "last-run").LastWriteTime
    (Get-ChildItem "last-run").LastWriteTime = Get-Date
}
else {
    $lastRunTime = New-Object DateTime(2000, 1, 1)
    New-Item "last-run" | Out-Null
}
Get-ChildItem -Path "*.jpg", "*.jpeg", "*.png" | 
Where-Object { $_.LastWriteTime -gt $lastRunTime } |
ForEach-Object {
    Write-S3Object -BucketName "my.aws.bucket" -ProfileName "MyProfile" -File $_.Name -Key $_.Name
}
