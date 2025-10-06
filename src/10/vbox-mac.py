#!/usr/bin/env python3
# usage: ./vbox-mac.py vbox/*.vbox
import os, sys
import xml.etree.ElementTree as ET 
namesp = { 'ns': 'http://www.virtualbox.org/'}
for xmlfile in sys.argv[1:]:
    basename = os.path.basename(xmlfile)
    root = ET.parse(xmlfile).getroot()
    machine = root.find('ns:Machine', namesp)
    hardware = machine.find('ns:Hardware', namesp)
    network = hardware.find('ns:Network', namesp)
    for adapter in network.findall('ns:Adapter', namesp):
        if 'MACAddress' in adapter.attrib:
            print('%30s: MAC=%s' % (basename, adapter.attrib['MACAddress']))
        