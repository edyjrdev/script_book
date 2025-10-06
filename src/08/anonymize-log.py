#!/usr/bin/env python3
import random, re, string, sys

# usage: ./anonymize-log in.log > out.log

# this scripts reads access.log.orig, which has to be a
# Apache logging file (apache combined format)
# it replaces IP adresses, user names and urls by random data
# output is written to stdout

# returns random IPv4 address
def randomIPv4():
    return ".".join(str(random.randint(0, 255)) for i in range(4))

# returns random IPv46 address
def randomIPv6():
    hex_chars = string.hexdigits[:16]
    return ":".join("".join(random.choice(hex_chars) for i in range(4)) for j in range(8))

# returns random URL, i.e. /foo/bar/lorem/ipsum
def randomUrl():
    noOfWords = random.randint(2, 4)
    return '/' + '/'.join(random.choice(words) for i in range(noOfWords))

# returns random user name, i.e. userbssd
def randomUsername():
    return 'user' + str(random.randint(100, 999))

# read word list, used by randomUrl
# https://www.ef.com/wwen/english-resources/english-vocabulary/top-1000-words/
with open('words.txt', 'r') as f:
    words = [ line.rstrip() for line in f ]
    
ips = {}
names = {}
urls = {}
referrers = {}

# regular expression to get components of apache combined logging
pattern = r'(.+?) - (.+?) \[(.+?)\] \"(.+?) (.+?) (.+?)\" (.+?) (.+?) \"(.+?)\" \"(.+?)\"'

# open file passed as first command line argument
with open(sys.argv[1], 'r') as f:
    for line in f:
        result = re.findall(pattern, line)
        if len(result):
            groups = list(result[0])  # tuple to list

            # replace ip address by random address,
            # save in dictionary for repeated use
            ip = groups[0]
            if ip not in ips:
                if ':' in ip:
                    ips[ip] = randomIPv6()
                else:
                    ips[ip] = randomIPv4()
            groups[0] = ips[ip]


            # replace user name
            uname = groups[1]
            if uname != '-':
                if uname not in names:
                    names[uname] = randomUsername()
                groups[1] = names[uname]

            # replace url
            url = groups[4]
            if url:
                if url not in urls:
                    urls[url] = randomUrl()
                groups[4] = urls[url]

            # replace referrer
            ref = groups[8]
            if ref:
                if ref not in referrers:
                    referrers[ref] = 'https://example.com' + randomUrl()
                groups[8] = referrers[ref] 


            agent = groups[9]
            if 'kofler.info' in agent:
                groups[9] = agent.replace('kofler.info', 'example.com')

            print('%s - %s [%s] "%s %s %s" %s %s "%s" "%s"' % 
                  tuple(groups))
