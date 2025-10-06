#!/usr/bin/env python3
# gets weather data and saves it in database
# requirements: 
#   * key for https://www.weatherapi.com/ (free for limited use)
#   * requests module (pip install requests)

import requests
# please get your own api key (free for limited services)
# at https://www.weatherapi.com/
key = "7901161c6b4e4806b4651739230304"
location = "Graz"
base = "https://api.weatherapi.com/v1/current.json"
url = base + "?key=" + key + "&q=" + location
data = requests.get(url).json()
temp = data['current']['temp_c']
condition = data['current']['condition']['text']
time = data['location']['localtime']    
with open("weather.csv", 'a') as f:
    f.write("%s;%s;%s\n" % (time, condition, temp))

print("Weather data appended to weather.csv")
