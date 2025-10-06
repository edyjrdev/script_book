#!/bin/bash 

# requirements: * Linux server with KVM virtualization system
#               * libvirt-tools including virsh (Debian/Ubuntu: apt install libvirt-clients)
#               * virt-clone (apt install virt-clone)
#               * base virtual machine to clone named 'vm-base'

# usage:   make-vms.sh <start> <end>
# example: make-vms.sh 10 29
#          creates 20 new virtual machines named vm-10 to vm-29
orig='vm-base'    # base VM to clone
for (( nr=$1; nr<=$2; nr++ )); do
  echo "create vm-$nr"
  disk=/var/lib/libvirt/images/vm-$nr-disk.qcow2
  virt-clone --name "vm-$nr" --original $orig \
     --mac 52:54:00:01:00:$nr --file $disk
done
