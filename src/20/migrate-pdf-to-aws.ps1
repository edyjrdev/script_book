#!/usr/bin/env pwsh
# downloads PDFs linked on source page, uploads them to AWS S3,
# changes links in original HTML code and saves the new code

# reqirements: * AWS Tools (Install-Module AWS.Tools.Common, Install-Module AWS.Tools.S3)
#              * AWS bucket configured for static webhosting
#              * AWS credentials to access bucket (run Set-AWSCredential ... -StoreAs MyProfile)

$bucket = "my.pdf.bucket"
$awsurl = "http://my.pdf.bucket.s3-website.eu-central-1.amazonaws.com/"
$region = "eu-central-1"
$awsprofile = "MyProfile"        # profile for AWS credentials
$htmlsource = "https://example.com/page-with-pdf-links.html"
$htmldest = "updated.html"       # file name for new HTML code

# set default region and default profile name for all AWS commands
Set-DefaultAWSRegion $region
Set-AWSCredential -ProfileName $awsprofile

# create temporary directory for PDF downloads
New-Item -ItemType Directory -Force tmp | Out-Null

$response = Invoke-WebRequest $htmlsource
$html = $response.Content
foreach ($link in $response.links) {
    $href = $link.href
    if ($href -match '.*pdf$') {
        Write-Output $href
        # get last part of URL
        $filename = $href.Substring($href.LastIndexOf("/") + 1)
        # download file to temporary directory
        Invoke-WebRequest $href -OutFile tmp\$filename
        # upload to AWS S3
        Write-S3Object -BucketName $bucket -File tmp\$filename -Key $filename 
        # build link
        $pdfAtAws = "$awsurl$filename"
        Write-Output $pdfAtAws
        # replace link in HTML document
        $html = $html.Replace("href=`"$href`"", "href=`"$pdfAtAws`"")
    }
}
# write new HTML code to destination file
$html | Out-File $htmldest