#!/usr/bin/env python3

# usage: ./hello-pyexiftool.py file1.jpg file2.jpg
# 
# requirements: * exiftool (install with apt/dnf or download from https://exiftool.org/)
#               * pyexiftool (pip install pyexiftool)

import exiftool, sys

filenames = sys.argv[1:]
keys = ['SourceFile', 'EXIF:Model', 'EXIF:ExposureTime', 'EXIF:ISO', 'EXIF:DateTimeOriginal']

with exiftool.ExifToolHelper() as exifhelper:
    # returns list of dictionaries, one dict. for each filename
    metadatalst = exifhelper.get_metadata(filenames)
    # show selected dictionary items
    for metadata in metadatalst:
        print()
        #for key in keys:
        #    # does the key exist?
        #    if key in metadata:
        #        print('%25s : %s' % (key, metadata[key]))
        # alternativ: print ALL available entries
        for key, value in metadata.items():
            print('%35s : %s' % (key, value))
