#!/usr/bin/env python3
import re
ok = False
pattern = r'^([a-fA-F0-9]{2}[:-]){5}[a-fA-F0-9]{2}$'
while not ok:
    mac = input('Enter a MAC address: ')
    ok = re.match(pattern, mac)
    if not ok:
        print('Not valid, please try again:')

print('Valid address:', mac)