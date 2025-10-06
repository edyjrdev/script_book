#!/usr/bin/env python3
import re
pattern = r'\d{4}-\d{2}-\d{2}'
txt = 'Eastern 2024 is on 2024-03-31.'
if result := re.search(pattern, txt):
    print(result.group())        # 2024-03-31

pattern = r'(\d{4})-(\d{2})-(\d{2})'
if result := re.search(pattern, txt):
    print(result.group())        # 2024-03-31
    print(len(result.groups()))  # 3
    year = result.group(1)
    month = result.group(2)
    day = result.group(3)
    print(year, month, day)      # 2024 12 31
