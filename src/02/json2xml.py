#!/usr/bin/env python
import json
fmt = "  <employee no='%s' birth_date='%s'>%s %s</employee>\n"
with open('employee.json', 'r') as jsonfile, open('employee.xml', 'w') as xmlfile:
    data = json.load(jsonfile)
    xmlfile.write('<?xml version="1.0"?>\n<employees>\n')
    for item in data:
        xmlfile.write(fmt % (item['emp_no'], item['birth_date'], item['first_name'], item['last_name']))
    xmlfile.write('</employees>\n')
