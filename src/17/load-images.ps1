#!/usr/bin/env pwsh

# download all images from startpage of website
# and save in tmp directory

# make local temporary directory
New-Item -ItemType Directory -Force tmp | Out-Null

$url = 'https://sap-press.com/'
$response = Invoke-WebRequest $url

# loop over images
foreach($image in $response.Images) {
    $src = $image.src
    if ($src.StartsWith('//')) {
        # protocol relativ link, add 'https'
        $src = "https:" + $src
    } elseif (! $src.StartsWith('http')) {
        # relative link, add base url
        $src = $url + $src
    }
    $filename = 'tmp/' + (Split-Path $image.src -Leaf)
    Write-Output ($src + " -> " +  $filename)
    # suppress status output of Invoke-Webrequest
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest $src -OutFile $filename 
    $ProgressPreference = 'Continue'
}
