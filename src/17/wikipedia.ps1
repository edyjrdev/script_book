#!/usr/bin/env pwsh
# requirements: PowerHTML (Install-Module PowerHTML)

# reads Wikipedia text about PowerShell and
# loops over all <h2> headers

$url = 'https://en.wikipedia.org/wiki/PowerShell'
$response = Invoke-WebRequest $url
$dom = ConvertFrom-Html $response
$content = $dom.SelectSingleNode("//div[@id='bodyContent']")
$headers = $content.SelectNodes("//h2")
foreach ($header in $headers) {
    $headline = $header.SelectSingleNode("span[@class='mw-headline']")
    Write-Output $headline.InnerText
}

