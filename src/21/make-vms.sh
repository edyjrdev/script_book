#!/bin/bash 

# requirements: * Linux server with KVM virtualization system
#               * libvirt-tools including virsh (Debian/Ubuntu: apt install libvirt-clients)
#               * virt-clone (apt install virt-clone)
#               * base virtual machine to clone named 'vm-base'

# usage:   make-vms.sh <start> <end>
# example: make-vms.sh 10 29
#          creates 20 new virtual machines named vm-10 to vm-29
if [ $# -ne 2 ]; then
	echo "usage: make-vms.sh <start> <end>"
	exit 1
fi
vmstart=$1
vmend=$2
orig='vm-base'    # base VM to clone

# shut down base system
result=$(virsh list | grep $orig)
if [ ! -z "$result" ]; then
  echo "shutting down $orig"
  virsh shutdown $orig
  sleep 10
fi
  
# clone 
for (( nr=$vmstart; nr<=$vmend; nr++ )); do
  echo "create vm-$nr"
  # create new virtual machines with three network adapters
  # and four disks
  disk1=/var/lib/libvirt/images/vm-$nr-disk1.qcow2
  disk2=/var/lib/libvirt/images/vm-$nr-disk2.qcow2
  disk3=/var/lib/libvirt/images/vm-$nr-disk3.qcow2
  disk4=/var/lib/libvirt/images/vm-$nr-disk4.qcow2
  tmpdisk=/var/lib/libvirt/images/tmpdisk.qcow2
  virt-clone --name "vm-$nr" --original $orig \
     --mac 52:54:00:01:00:$nr --mac 52:54:00:02:00:$nr \
     --mac 52:54:00:03:00:$nr \
     --file $disk1 --file $disk2 --file $disk3 --file $disk4
  
  # virt-clone creates RAW disks; convert to QCOW2 format
  qemu-img convert $disk1 -O qcow2 $tmpdisk
  mv $tmpdisk $disk1
  qemu-img convert $disk2 -O qcow2 $tmpdisk
  mv $tmpdisk $disk2
  qemu-img convert $disk3 -O qcow2 $tmpdisk
  mv $tmpdisk $disk3
  qemu-img convert $disk4 -O qcow2 $tmpdisk
  mv $tmpdisk $disk4
done
