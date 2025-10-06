#!/usr/bin/env pwsh

do {
    $color = Read-Host "Enter a CSS color (#ccc or #cccccc)"
} until ($color -match "^#([0-9a-fA-F]{3}){1,2}$")
Write-Host "Valid color code: $color"

