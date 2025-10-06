#!/usr/bin/env python3
# requirements: * beautifulsoup4 (pip install beautifulsoup4)
#               * requests-html  (pip install requests-html)
# works as of 2023-03-26, but will break if githubstatus.com 
# changes website layout

from requests_html import HTMLSession
from bs4 import BeautifulSoup

# download html code, render including JavaScript code
# (downloads local copy of Chromium on first run)
url = "https://www.githubstatus.com/"
session = HTMLSession()
response = session.get(url)  # response object
response.html.render()

# parse HTML content using BeautifulSoup
dom = BeautifulSoup(response.html.html, 'html.parser')
dict = {}

# loop through components 
containers = dom.find_all('div', class_ = 'component-container')
for container in containers:
    # skip invisible containers
    if container.has_attr('style') and container['style'] == 'display: none;':
        continue
    name = container.find('span', class_='name').contents[0].strip()
    status = container.find('span', class_='status-msg').contents[0].strip()
    dict[name] = status

# show result dictionary    
print(dict)
print(dict['Git Operations'])