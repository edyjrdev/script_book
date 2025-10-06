#!/usr/bin/bash
# executes various commands in virtual maschines 
# and saves the results in vm<nn>.txt
VMNAMES=$(echo host{10..25})
VMHOST=mylab.com
USER=username
CMDS='hostnamectl; echo; ip addr; echo; lsblk'

for vm in $VMNAMES; do
  echo $vm
  ssh $USER@$vm.$VMHOST -o StrictHostKeyChecking=no "$CMDS" > result-$vm.txt
done
