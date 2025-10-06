#!/usr/bin/env python3
from configparser import ConfigParser
config = ConfigParser()
config.read('config.ini')
print(config['server']['port'])   # output 8080
