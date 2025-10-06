#!/usr/bin/env python3
import json

# read JSON file into variable
with open('employees.json', 'r') as f:
    employees = json.load(f)
  
# read JSON string (loads, not load!)
txt = '{"key1": "value1", "key2": "value2"}'
data = json.loads(txt)
  
# process data['keylevel1']['keylevel2'] ...
print(data['key2'])   # output: value2
  
# save content of python object (list, dictionary)
# in a json file (utf-8)
with open('otherfile.json', 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print(json.dumps(data, indent=2, ensure_ascii=False))
# output:
# {
#   "key1": "value1",
#   "key2": "value2"
# }