#!/bin/bash 

# requirements: * Linux server with KVM virtualization system
#               * libvirt-tools including virsh (Debian/Ubuntu: apt install libvirt-clients)
#               * virtual machines named 'vm-<nnn>'

# usage:   delete-vms.sh <start> <end>
# example: delete-vms.sh 10 29
#          deletes 20 existing virtual machines named vm-10 to vm-29
if [ $# -ne 2 ]; then
    echo "usage: delete-vms.sh <start> <end>"
    exit 1
fi
vmstart=$1
vmend=$2

for (( nr=$vmstart; nr<=$vmend; nr++ )); do
  echo "delete vm-$nr"
  virsh undefine "vm-$nr" --remove-all-storage
done
