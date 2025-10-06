#!/bin/bash 

# requirements: * Linux server with KVM virtualization system
#               * libvirt-tools including virsh (Debian/Ubuntu: apt install libvirt-clients)
#               * virtual machines named 'vm-<nnn>'

# usage:   start-vms.sh <start> <end>
# example: start-vms.sh 10 29
#          starts 20 existing virtual machines named vm-10 to vm-29
if [ $# -ne 2 ]; then
    echo "usage: start-vms.sh <start> <end>"
    exit 1
fi
vmstart=$1
vmend=$2

for (( nr=$vmstart; nr<=$vmend; nr++ )); do
  echo "start vm-$nr"
  virsh start "vm-$nr"
done
