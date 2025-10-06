#!/usr/bin/env python3
from urllib import parse, request
import os, re

# create temporary directory
os.makedirs("tmp/", exist_ok=True)

# load html code
url = "https://sap-press.com"
with request.urlopen(url) as response:
    html = response.read().decode('utf8')

# use regex to find <img src="..." pattern!
imageUrls = re.findall(r'<img.*?src=\"(.+?)\"', html)
for imgUrl in imageUrls:
    # build absolute url from relative linke
    if not imgUrl.startswith('http'):
        imgUrl =  parse.urljoin(url, imgUrl)
    # build destination path
    path = parse.urlsplit(imgUrl).path
    basename = os.path.basename(str(path))
    destination = 'tmp/' + basename
    try:
        # download image, save in local file
        with request.urlopen(imgUrl) as response, open(destination, 'wb') as f:
            f.write(response.read())
        print(basename)
    except:
        print("skipped", basename[:30])
