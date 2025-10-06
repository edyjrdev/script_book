#!/usr/bin/env pwsh
# read xml document, extract CHF rate and date
$csv = "chf-rates.csv"
$url = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"
$ecb = Invoke-RestMethod $url
$date = $ecb.Envelope.Cube.Cube.time
$rate = ($ecb.Envelope.Cube.Cube.Cube | 
           Where-Object {$_.currency -eq 'CHF'}).rate

# create CSV file if neccessary
if (!(Test-Path $csv)) {
    "date;chf_rate" | Out-File $csv
}
# append line with exchange rate
Add-Content $csv "$date;$rate"
