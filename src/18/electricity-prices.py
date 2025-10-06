#!/usr/bin/env python3

# reads Attawar API and generates diagram with 
# prices for the next 24 hours 

# requirements: requests   (pip install requests)
#               matplotlib (pip install matplotlib)

import requests
from datetime import datetime
import locale
import matplotlib.pyplot as plt

# use system settings to set language for day names
locale.setlocale(locale.LC_ALL, '')

surcharge = 0.03   # Awattar
vat = 0.20         # 20% VAT (Austria); use 0.19 for Germany

url = 'https://api.awattar.at/v1/marketdata'   # Austria
# url = 'https://api.awattar.de/v1/marketdata' # Germany

response = requests.get(url)
jsondata = response.json()

hours = []
prices = []
dateStart = None

# show prices as text
for price in jsondata['data']:
    startDt = \
      datetime.fromtimestamp(price['start_timestamp'] / 1000)
    hour = startDt.strftime('%H:%M')
    day = startDt.strftime('%a')
    if not dateStart:  # initialize only once
        dateStart = startDt.strftime('%Y-%m-%d')
    dateEnd = startDt.strftime('%Y-%m-%d')  # overwrite
    priceCentKw = round(price['marketprice'] / 10 * (1 + surcharge) * (1 + vat))
    priceBar = '*' * int(priceCentKw)
    print('%s %s %3d ct/kWh %s' % (day, hour, priceCentKw, priceBar))
    hours += [hour]
    prices += [priceCentKw]

# plot a simple diagram
fig, ax = plt.subplots()
ax.bar(hours, prices)
plt.xticks(rotation=90)
plt.title('Prices in ct/kWh from %s to %s' % (dateStart, dateEnd))
# hide every second x tick label
for label in ax.xaxis.get_ticklabels()[::2]:
    label.set_visible(False)
fig.savefig('prices.png', dpi=200) 
