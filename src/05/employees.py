#!/usr/bin/env python3

# task 1: formatted output of firstname, lastname and date of birth
with open('employees.csv', 'r') as f:
    for line in f:
        columns = line.split(',')
        # print('%-20s %-20s %s' % tuple(columns[1:4]))

# task 2: write employees.sql with INSERT commands
cmd = 'INSERT INTO employees (%s)\nVALUES (%s);\n'
with open('employees.csv', 'r') as csv,\
     open('employees.sql', 'w') as sql:
    
    # get column names from first line
    columnnames = csv.readline().rstrip().replace(',', ', ')

    # read other lines
    for line in csv:
        columns = line.rstrip().split(',')
        # quote items, i.e. 'Peter', 'Smith' ...
        data = ["'" + c + "'" for c in columns]
        values = ', '.join(data)
        sql.write(cmd % (columnnames, values))
