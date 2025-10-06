#!/usr/bin/env python3
import csv
total = 0
with open('2023_population.csv', newline = '') as f: 
    reader = csv.reader(f, delimiter = ',', quotechar='"')
    next(reader)            # skip first line with column headers
    for columns in reader:  # reads one line, returns list of strings
        print(columns)
        total += int(columns[2].replace(',', ''))

print("Earth population:", total)
