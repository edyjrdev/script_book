#!/bin/bash 

# requirements: this bash script needs a very complex server setup and
#               cannot be tested locally;
#               you would need an Debian/Ubuntu server 
#               with Apache, MySQL/MariaDB and Postfix,
#               PHP code for a web application
#               and a MySQL/MariaDB template database;
#               the script also requires makepasswd (apt install makepasswd)
#                                    and htpasswd (apt install apache2-utils) 


# source file with account data
. accountdata

# cancel if database already exists
sql="SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA 
     WHERE SCHEMA_NAME='$DB'"
result=$(mysql -s -N -e "$sql")
echo "result = $result"
if [ "$result" ]; then
  echo "Database $DB already exists."
  exit
fi

# password for database access (internal, to be saved in config file)
dbpw=$(makepasswd)
# password for web login
loginpw=$(makepasswd)

# create new database, initialize it with a copy of template database
mysqladmin create $DB
mysql $DB | mysqldump template

# setup database account for new database
sql="CREATE USER $DB@localhost IDENTIFIED BY '$dbpw';
     GRANT ALL ON $DB.* TO $DB@localhost"
mysql -e "$sql"

# make hash code for login password
hash=$(htpasswd -bnBC 10 "" $loginpw | tr -d ':\n')
# insert customer data into customer database
sql="INSERT INTO accounts (firstname, lastname, company, 
                           email, hashcode) 
     VALUES ('$FIRSTNAME', '$LASTNAME', '$COMPANY', 
             '$EMAIL', '$hash')"
mysql $DB -e "$sql"

# setup local web directory
cd /var/www/html/myapplication
mkdir $URL
cat > $URL/dbconfig.php << EOF
<?php
LocalConfig::set('dbname', '$DB');
LocalConfig::set('dbhost', 'localhost');
LocalConfig::set('dbuser', '$DB');
LocalConfig::set('dbpass', '$dbpw');
EOF

chown -R www-data:www-data $URL
chmod -R o-rwx $URL
chown root:www-data $URL/dbconfig.php
chmod 640 $URL/dbconfig.php

# send mail to new customer
BODY="Dear customer,
\n
\nthis is your login data:
\n
\nLogin:        https://example.com/$URL
\nAccount:      $EMAIL
\nPasswort:     $loginpw
\n
\nPlease change your password after the first login!
"

echo -e $BODY | mail -s "your new account"  \
    -a "From: support@example.com" \
    -a "Content-Type: text/plain; charset=UTF-8" \
    $EMAIL
