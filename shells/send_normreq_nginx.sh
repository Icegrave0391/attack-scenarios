#!/bin/bash

NGX_SERVER_IP="172.26.187.140:8080"
# request normal files
for i in $(seq 1 100)
do
    echo "requesting NGX file: file$i.txt..."
    curl $NGX_SERVER_IP/data/file$i.txt > /dev/null  2>&1
    sleep 0.5
done 

