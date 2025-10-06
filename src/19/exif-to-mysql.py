#!/usr/bin/env python3

# usage: ./exif-to-sql.py *.jpg > cmds.sql
#
# requirements: * exiftool (install with apt/dnf or download from https://exiftool.org/)
#               * pyexiftool (pip install pyexiftool)
#               * pymysql  (pip install pymysql)
#               * MySQL/MariaDB server (update connection data below!)
#               * table photos:
#                  CREATE TABLE photos(
#                    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
#                    name VARCHAR(255) NOT NULL,
#                    size INT,
#                    orientation INT,
#                    datetimeoriginal DATETIME,
#                    latitude DOUBLE,
#                    longitude DOUBLE,
#                    altitude DOUBLE,
#                    ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
#                   );

import exiftool
import inspect
import sys
import pymysql.cursors
from glob import glob

# connect to MySQL/MariaDB server
conn = pymysql.connect(host='example.com',
                       user='dbusername',
                       password='topsecret',
                       db='scripting',
                       port=3306,
                       charset='utf8mb4',
                       cursorclass=pymysql.cursors.DictCursor)


# globbing, necessary for only for Windows, doesn't hurt for other OSs
filenames = []
for arg in sys.argv[1:]:
    filenames.extend(glob(arg))

# read only this EXIF keys (names as in pyexiftool)
keys = ['File:FileName', 'File:FileSize', 'EXIF:Orientation',
        'EXIF:DateTimeOriginal', 'EXIF:GPSLatitude',
        'EXIF:GPSLongitude', 'EXIF:GPSAltitude']

# SQL command to insert record; cleandoc removes indentation
sql = inspect.cleandoc("""
  INSERT INTO photos (name, size, orientation, datetimeoriginal,
                      latitude, longitude, altitude)
  VALUES (%s, %s, %s, %s, %s, %s, %s);""")

# connect to local exiftool, setup cursor for database commands
with exiftool.ExifToolHelper() as exifhelper, \
     conn.cursor() as cur:

    # loop over files
    for file in filenames:
        # collect EXIF tags (or None if not present)
        results = []
        try:
            metadata = exifhelper.get_tags(file, keys)[0]
            for key in keys:
                if key in metadata:
                    if key == 'EXIF:DateTimeOriginal':
                        date = str(metadata[key])
                        results += [ date.replace(':', '-', 2) ]
                    else:
                        results += [str(metadata[key])]
                else:
                    results += [ None ]
            # execute INSERT
            cur.execute(sql, results)
        except Exception as e:
            print("-- skipped %s" % (file))

# commit all inserts, close database connection
conn.commit()
conn.close()
