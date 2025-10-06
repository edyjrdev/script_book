#!/usr/bin/env python3
import json

with open('employees.json') as f:
    employees = json.load(f)

# gather birtdates
birthdates = {}  # empty dictionary
for employee in employees:
    birthdate = employee['DateOfBirth'][5:]  # [5:] skip year, only month and day
    name = employee['FirstName'] + ' ' + employee['LastName']
    if birthdate in birthdates:
        # add name to list
        birthdates[birthdate].append(name)
    else:
        # new list for this birthdate
        birthdates[birthdate] = [name]

# test: all employees who have birtday on 01/24
# output: ['Nannette Ramsey', 'Allena Hoorenman', 
#          'Arden Lit', 'Duncan Noel']
print(birthdates['01-24'])