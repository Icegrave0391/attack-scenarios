#!/bin/bash

FTP_SERVER_IP="ftp://172.26.187.140:9121/"
USER="chuqi"
PASS="chuqi"

FILE_DIR=/home/chuqi/web-source/

# request normal files
for i in $(seq 1 100)
do
    echo "requesting PURE-FTPD file: file$i.txt..."
    curl --insecure -p "$FTP_SERVER_IP""$FILE_DIR"/data/file$i.txt -u $USER:$PASS > /dev/null  2>&1
    sleep 0.5
done 

# request unrestricted files
for file in "/etc/passwd" "/etc/group"
do 
    echo "requesting PURE-FTPD file: $file..."
    curl --insecure -p "$FTP_SERVER_IP""$file" -u $USER:$PASS > /dev/null  2>&1
done
