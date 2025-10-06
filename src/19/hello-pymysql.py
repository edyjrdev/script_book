#!/usr/bin/env python3
# requirements: * PyMySQL module (pip install pymysql)
#               * MySQL/MariaDB server with database (update connection data below!)
#               * table photos:
#                  CREATE TABLE photos(
#                    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
#                    name VARCHAR(255) NOT NULL,
#                    size INT,
#                    orientation INT,
#                    datetimeoriginal DATETIME,
#                    latitude DOUBLE,
#                    longitude DOUBLE,
#                    altitude DOUBLE,
#                    ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
#                   );


import pymysql.cursors

# connect to MySQL/MariaDB server
conn = pymysql.connect(host='localhost',
                       user='username',
                       password='topsecret',
                       db='dbname',
                       port=3306,
                       charset='utf8mb4',
                       cursorclass=pymysql.cursors.DictCursor)

# SELECT all records of photos table
sql = 'SELECT * FROM photos WHERE id < %s'
with conn.cursor() as cur:
    cur.execute(sql, (1000))
    while row := cur.fetchone():
        print(row)

# INSERT a new record
sql = '''INSERT INTO photos (name, size, orientation)
         VALUES (%s, %s, %s)'''
with conn.cursor() as cur:
    cur.execute(sql, ('img_1234.jpg', 3231283, 0))
    conn.commit()
    print('ID of new record:', cur.lastrowid)

conn.close()