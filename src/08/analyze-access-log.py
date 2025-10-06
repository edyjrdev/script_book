#!/usr/bin/env python3
counters = {}   # Dictionary with counters for all IP addresses

# loop over all lines
with open('access.log') as f:
    for line in f:
        ip = line.split()[0]  # extract first column
        if ip in counters:
            counters[ip] += 1
        else:
            counters[ip] = 1

# create sorted list of dictionary items
# each item is itself a list: [ip, cnt]
sortedIps = sorted(counters.items(),
                   key = lambda x: x[1], reverse = True)

# show top 5 addresses
for i in range(5):
    print('%6d: %s' % (sortedIps[i][1], sortedIps[i][0]))
