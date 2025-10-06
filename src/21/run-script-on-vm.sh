#!/bin/bash 

# requirements: * several running VMs with sequential numbers in hostnames or ip address
#               * local public SSH key installed on all VMs in /root/.ssh/authorized_keys
#               * local file ./myscript.sh with the commands to execute on the VMs

# usage:   run-script-on-vms.sh <start> <end>
# example: run-script-on-vms.sh 10 29
#          runs the commands from myscript.sh on VMs vm-10.example.com to vm-29.example.com

if [[ $# -ne 2 ]]; then
        echo "usage: run-script-on-vms.sh <start> <end>"
        exit 1
fi

vmstart=$1
vmend=$2
for (( nr=$vmstart; nr<=$vmend; nr++ )); do
    ssh -o StrictHostKeyChecking=no \
      root@vm-$nr.example.com 'bash -s' \
      < myscript.sh > results-$nr.txt
done

