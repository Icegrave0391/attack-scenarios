#!/bin/bash

NGX_SERVER_IP="172.26.187.140:8080"

for file in secret1.txt secret2.csv secret3.png
do
    if [ "${file##*.}" = "png" ]; then
        DIR="images"
    else
        DIR="data"
    fi
    echo "requesting NGX secret file: $file..."
    curl $NGX_SERVER_IP/$DIR/$file > /dev/null  2>&1
    sleep 0.5
done 