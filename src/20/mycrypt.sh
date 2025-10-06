#!/bin/bash
# encrypts a file
# usage mycrypt.sh < in > out.crypt
# requirements: gpg
#               mykey file with random key (should be at least 16 byte)

gpg -c -q --batch --cipher-algo AES256 --compress-algo none --passphrase-file mykey 
