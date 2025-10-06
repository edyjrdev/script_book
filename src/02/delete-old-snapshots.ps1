#!/usr/bin/env pwsh
# deletes all Hyper V snapshots older than 30 days (caution!)
# requirements: Windows + Hyper V
#               administration rights 
$days = 30
$aMonthAgo = (Get-Date).AddDays(-$days) 
foreach ($snapshot in Get-VMSnapshot -VMName *) {
    if ($snapshot.CreationTime -lt $aMonthAgo) {
        $vmname = $snapshot.VMName
        $snapname = $snapshot.Name
        Write-Output "delete snapshot '$snapname' of VM '$vmname'"
        Remove-VMSnapshot -VMName $vmname -Name $snapname -Confirm 
    }
}

