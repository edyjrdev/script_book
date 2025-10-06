#!/usr/bin/env python3
import os
startdir = os.path.expanduser('~')
print('All files and directories in', startdir)
for filename in os.listdir(startdir):
    fullname = os.path.join(startdir, filename)
    if os.path.isfile(fullname):
        print("File: ", fullname)
    elif os.path.isdir(fullname):
        print('Directory: ', fullname)

print()
print('-----------')
print('All *.pdf files in', startdir)
for filename in os.listdir(startdir):
    if not filename.lower().endswith('.pdf'): continue
    fullname = os.path.join(startdir, filename)
    if os.path.isfile(fullname):
        print('PDF file: ', fullname)

