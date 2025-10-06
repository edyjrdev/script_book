Set-StrictMode -Version 3.0

$Drives = Get-CimInstance -ClassName Win32_LogicalDisk

foreach ($Drive in $Drives) {
    if ($Drive.DriveType -eq 3) {
        $PercentageFree = 1.0 * $Drive.FreeSpace / $Drive.Size
        $GBFree = $Drive.FreeSpace / 1000000000
	"{0:S} {1:P1}  /  {2,5:F0} GB free" -f `
            $Drive.DeviceId, $PercentageFree, $GBFree
    }
}

# alternative implementation
#
# $Drives | Where-Object -Property DriveType -eq 3 | ForEach {
#     $PercentageFree = 1.0 * $_.FreeSpace / $_.Size
#     $GBFree = $_.FreeSpace / 1000000000
#     "{0:S} {1:P1}  /  {2,5:F0} GB free" -f `
#          $_.DeviceId, $PercentageFree, $GBFree
# }
