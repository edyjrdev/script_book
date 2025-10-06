#!/usr/bin/env pwsh
$config = Get-Content 'config.ini' | 
          Select-String '^.*=.*[^=]*$' | 
          ConvertFrom-StringData
$config.port   
$config.notvalid