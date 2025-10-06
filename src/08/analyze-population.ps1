#!/usr/bin/env pwsh
$population = Import-CSV "2023_population.csv"
$total = 0
$population | ForEach-Object {
    $total += [long]($_.'2023_last_updated'.Replace(',', ''))
}
Write-Output "World population: $total"


# variant using Measure-Object
$total = $population | ForEach-Object {
     [long]($_.'2023_last_updated'.Replace(',', ''))
} | Measure-Object -Sum 
Write-Output "World population: $($total.Sum)"
