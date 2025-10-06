#!/usr/bin/env python3
import xml.etree.ElementTree as ET        
import urllib.request

url      = 'http://feeds.bbci.co.uk/news/world/rss.xml'
response = urllib.request.urlopen(url)
binary   = response.read()        # binary data
txt      = binary.decode('utf-8') # decode as utf-8 text

root = ET.fromstring(txt)  # rss root tag
cnt = 0
for item in root.iter('item'):
    print('*', item.find('title').text)
    print(' ', item.find('link').text)
    cnt += 1
    if cnt >= 10:
        break