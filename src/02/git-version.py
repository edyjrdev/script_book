#!/usr/bin/env python3
# retrieves git version number from git-scm.com
# requirements: requests module (pip install requests)
#               BeautifulSoup   (pip install beautifulsoup4)
import requests
from bs4 import BeautifulSoup
response = requests.get("https://git-scm.com/downloads")
dom = BeautifulSoup(response.content, 'html.parser')
version = dom.find('span', class_='version')
print("Git version:", version.text.strip())
url = version.parent.find('a')
print("What's new:", url.attrs['href'])
