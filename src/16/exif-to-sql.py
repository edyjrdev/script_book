#!/usr/bin/env python3

# usage: ./exif-to-sql.py *.jpg > cmds.sql
#
# requirements: * exiftool (install with apt/dnf or download from https://exiftool.org/)
#               * pyexiftool (pip install pyexiftool)

import exiftool, inspect, platform, sys
from glob import glob

# globbing, necessary for only for Windows, doesn't hurt for other OSs
if platform.system() == 'Windows':
    filenames = []
    for arg in sys.argv[1:]:
        filenames.extend(glob(arg))
else:
    filenames = sys.argv[1:]

# read only this EXIF keys (names as in pyexiftool)
keys = ['File:FileName', 'File:FileSize', 'EXIF:Orientation',
        'EXIF:DateTimeOriginal', 'EXIF:GPSLatitude',
        'EXIF:GPSLongitude', 'EXIF:GPSAltitude']

# SQL command to insert record; cleandoc removes indentation
sql = inspect.cleandoc("""
  INSERT INTO photos (name, size, orientation, datetimeoriginal,
                      latitude, longitude, altitude)
  VALUES (%s, %s, %s, %s, %s, %s, %s);""")

# connect to local exiftool
with exiftool.ExifToolHelper() as exifhelper:

    # loop over files
    for file in filenames:
        # collect EXIF tags (or NULL if not present)
        results = []
        try:
            metadata = exifhelper.get_tags(file, keys)[0]
            for key in keys:
                if key in metadata:
                    if key == 'EXIF:DateTimeOriginal':
                        # 2023:12:13 -> 2023-12-13
                        date = str(metadata[key]).replace(':', '-', 2)
                        results += [ "'%s'" % (date) ]
                    else:
                        results += [ "'%s'" % (metadata[key]) ]
                else:
                    results += ['NULL']
            print(sql % tuple(results))
        except Exception as e:
            print("-- skipped %s" % (file))
            # print(e)

