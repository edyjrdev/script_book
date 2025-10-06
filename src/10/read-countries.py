#!/usr/bin/env python3
import xml.etree.ElementTree as ET        
root = ET.parse('countries.xml').getroot()
countries = {}  # empty dictionary
for country in root:
    countries[country.attrib['code']] = country.text

print(countries['CH'])   # output Switzerland

