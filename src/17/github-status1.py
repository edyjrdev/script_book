#!/usr/bin/env python3
# requirements: * requests-html  (pip install requests-html)
# works as of 2023-03-26, but will break if githubstatus.com 
# changes website layout

from requests_html import HTMLSession

# download html code, render including JavaScript code
# (downloads local copy of Chromium on first run)
url = "https://www.githubstatus.com/"
session = HTMLSession()
response = session.get(url)  # response object
response.html.render()

# results
dict = {}

# loop through components 
containers = response.html.find('div.component-container')
for container in containers:
    # skip invisible containers
    if 'style' in container.attrs and container.attrs['style'] == 'display: none;':
        continue    
    name = container.find('span.name', first=True).text.strip()
    status = container.find('span.status-msg', first=True).text.strip()
    dict[name] = status

# show result dictionary    
print(dict)
print(dict['Git Operations'])