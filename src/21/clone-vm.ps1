#!/usr/bin/env pwsh
# requirements: Windows computer with Hyper-V
#               script is to be run with administrative rights
#               directory for clone files must not exist

$basename = "alma9"
$noOfClones = 2
$tmp = $env:TEMP

# this function tests, if directory exists, then deletes it
# use with caution!
function delete-dir($path) {
    if (Test-Path "$path") {
        Write-Output "delete $path"
        Remove-Item "$path" -Recurse -Force
    }
}

# if VM is running: stop it
$basevm = Get-VM $basename
if ($basevm.State -eq 'Running' ) {
    Write-Output "shutdown $basename"
    Stop-VM -VM $basevm
}
# delete all snapshots (caution!)
Get-VMSnapshot -VM $basevm | Remove-VMSnapshot

# get directory of first image file
$pathFirstDisk =  (Get-VMHardDiskDrive -VM $basevm | Select-Object -First 1).Path
$dirFirstDisk = Split-Path $pathFirstDisk -Parent
Write-Output "Virtual disk directory: $dirFirstDisk"

# if export directory exists: delete it (caution!)
delete-dir "$tmp\$basename"

# export it in temp directory (creates a new subdirectory $basename)
Export-VM -VM $basevm -Path $tmp 
$vmcxfile = Get-ChildItem "$tmp\$basename\Virtual Machines\*.vmcx"
Write-Output "VMCX file: $vmcxfile"

# create $noOfClones copies of exported VM
for ($i = 1; $i -le $noOfClones; $i++) {
    $cloneName = "${basename}-clone${i}"
    $mac="00155d1234{0:d2}" -f $i
    Write-Output "setup $cloneName with MAC $mac"

    # import vm
    $clone = Import-VM -Path $vmcxfile -Copy -GenerateNewId `
        -VhdDestinationPath "$dirFirstDisk\$cloneName\" `
        -VirtualMachinePath "$dirFirstDisk\$cloneName\"

    # rename clone
    Rename-VM -VM $clone -NewName $cloneName

    # setup VM properties
    Set-VM -VM $clone -ProcessorCount 1 `
      -MemoryStartupBytes 1GB
     
    # set static MAC
    $mac="00155d1234{0:d2}" -f $i
    Set-VMNetworkAdapter -VMName $cloneName -StaticMacAddress $mac
}
# delete export directory
delete-dir "$tmp\$basename"
