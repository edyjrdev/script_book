#!/usr/bin/env python3
import sys
if(len(sys.argv) <= 1):
    print("Es wurden keine Parameter übergeben.")
else:
    for x in sys.argv[1:]:
         print("Parameter:", x)
         