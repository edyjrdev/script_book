#!/usr/bin/env python3
import requests

# get request
response = requests.get('https://httpbin.org/get?q=123')
print(response.content.decode('utf-8'))

data = response.json()
print(data)

print("Status:", response.status_code)

# put request
data = {'firstName': 'John', 'lastName': 'Doe'}
response = requests.put('https://httpbin.org/put', json=data)
print(response.json())

# basic authentication
url = 'https://httpbin.org/basic-auth/maria/topsecret'
response = requests.get(url, auth=('maria', 'topsecret'))
print("Basic Authentication", response.status_code)

# bearer authentication
token = "234f1523werf"
headers = {"Authorization": "Bearer %s" % (token)}
url = 'https://httpbin.org/bearer'
response = requests.get(url, headers=headers)
print("Bearer Authentication", response.status_code)


