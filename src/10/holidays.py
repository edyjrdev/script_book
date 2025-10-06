#!/usr/bin/env python3
# usage:
#   ./holidays.py          # lists holidays for the US for current year
#   ./holidays.py 2023     # lists holidays for the US for 2023
#   ./holidays.py DE       # lists holidays for Germany for current year
#   ./holidays.py FR 2024  # lists holidays for France for 2024
#   ./holidays.py 2024 FR  # same

import datetime
import json
import sys
import urllib.request

# please get your own key (free for non-commercial use)
# at https://calendarific.com/
api_key = "23cd87bb085b9237a96fdde5722c53543856e6fd"

# default settings
country = 'US'
year = datetime.datetime.now().year

# process command line arguments, try to get country codes or year
for arg in sys.argv[1:]:
    if arg.isdigit():
        year = arg
    else:
        country = arg
print("Holidays for", country, "in", year)

# process web request
query = "https://calendarific.com/api/v2/holidays?api_key=%s&country=%s&year=%s"
url = query % (api_key, country, year)
req = urllib.request.Request(url,
                             headers={"User-Agent": "curl"})
response = urllib.request.urlopen(req)
txt = response.read().decode("utf-8")

# extract data from JSON document
data = json.loads(txt)
for holiday in data['response']['holidays']:
    name = holiday['name']
    date = holiday['date']['iso']
    descr = holiday['description']
    print('%s: %s' % (date, name))
    print('  %s' % (descr))
