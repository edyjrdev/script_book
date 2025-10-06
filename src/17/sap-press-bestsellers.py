#!/usr/bin/env python3
# requirements: * beautifulsoup4 (pip install beautifulsoup4)
#               * requests (pip install requests)
# works as of 2023-11-10, but will break if SAP Press
# changes its website layout
import requests
import urllib.parse
from bs4 import BeautifulSoup

# parse HTML content using BeautifulSoup
siteurl = "https://www.sap-press.com/bestsellers/"
response = requests.get(siteurl)
dom = BeautifulSoup(response.content, 'html.parser')

# find the section that contains the bestsellers
bestsellers = dom.find('ul', class_ = 'bestsellers-list')

# extract the titles and their detail page links
articles = bestsellers.find_all('article')
for article in articles:
    print('*', article['data-title'])
    link = article.find('a')['href']
    bookurl = urllib.parse.urljoin(siteurl, link)
    print(' ', bookurl)
