#!/usr/bin/env python3
# requirements: * beautifulsoup4 (pip install beautifulsoup4)
#               * requests (pip install requests)
import requests
from bs4 import BeautifulSoup

# parse HTML content using BeautifulSoup
siteurl = "https://kofler.info/"
response = requests.get(siteurl)
dom = BeautifulSoup(response.content, 'html.parser')
images = dom.find_all('img')
for img in images:
    print(img['src'])
