#!/bin/bash
# decrypts a file
# usage mycrypt.sh < in.crypt > out
# requirements: gpg
#               mykey file with random key (should be at least 16 byte)

gpg -d --batch --no-tty -q --cipher-algo AES256 --compress-algo none --passphrase-file mykey