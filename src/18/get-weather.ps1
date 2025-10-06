#!/usr/bin/env pwsh


# please get your own api key (free for limited services)
# at https://www.weatherapi.com/
$key = "7901161c6b4e4806b4651739230304"

# get location (longitude + latitude)
$location = (Invoke-RestMethod "https://ipinfo.io" `
          -Headers @{'User-Agent' = 'curl'}).loc

# get weather at this location
$base = "https://api.weatherapi.com/v1/current.json"
$url = "${base}?key=$key&q=$location&aqi=no"
# Write-Output $url
$response = Invoke-WebRequest $url
$content = $response.Content | ConvertFrom-Json
$city = $content.location.name
$temp = $content.current.temp_c
$text = $content.current.condition.text
Write-Output "Current weather in ${city}: $text at $temp °C"
