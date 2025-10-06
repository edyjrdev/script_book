#!/bin/bash

# configure network interfaces according to MAC address
# for RHEL 9 & clones
# requirements: * this script runs *within* the virtual machine;
#               * the example in this book assumes that the script 
#                 is saved in /etc/myscripts/ in the virtual machine 'vm-base';
#                 it is executed by /etc/rc.d/rc.local
#               * the code requires two network interfaces, one for ipv4 and one for ipv6
#               * the network configration is done static and uses NetworkManager syntax
#               * there are already existing configuration files which can be changed

NMPATH=/etc/NetworkManager/system-connections
IF1=enp1s0
IF2=enp7s0

# network configuration files
conffile1=$NMPATH/$IF1.nmconnection
conffile2=$NMPATH/$IF2.nmconnection

# get last 2 digits from MAC, remove leading 0
mac=$(cut -d ':' -f 6 /sys/class/net/$IF1/address)
if [ ${mac:0:1} == 0 ]; then mac=${mac:1:2}; fi

# ip addresses for interface 1 and 2
ip4old="192\.168\.122\..*/24"
ip4new="192\.168\.122\.$mac/24"
ip6old="2a01:abcd:abcd::.*/64"
ip6new="2a01:abcd:abcd::$mac/64"

# change configuration files if ipv4 address does not match
if ! grep -q "address1=$ip4new" $conffile1; then
  sed -E -i.old  "s,$ip4old,$ip4new," $conffile1
  sed -E -i.old  "s,$ip6old,$ip6new," $conffile2
  rm /etc/machine-id
  systemd-machine-id-setup
  echo "reboot"
  reboot
else
  echo "no network changes"
fi
