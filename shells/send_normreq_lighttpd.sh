#!/bin/bash

LIGHTTPD_SERVER_IP="172.26.187.140:8580"
# request normal files
for i in $(seq 1 100)
do
    echo "requesting LIGHTTPD file: file$i.txt..."
    curl $LIGHTTPD_SERVER_IP/file$i.txt > /dev/null  2>&1
    sleep 0.5
done 

