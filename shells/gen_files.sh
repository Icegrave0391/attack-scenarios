#!/bin/bash
NGX_FILE_DIR=/home/chuqi/web-source/data
LIGHTTPD_FILE_DIR=/home/chuqi/lighttpd-sources/htdocs
SECRET_FILE_DIR=/home/chuqi/secrets

# generate ngx files
for i in $(seq 1 100)
do
        echo "this is content of file$i" > $NGX_FILE_DIR/file$i.txt
done

# generate conf files for ftp
for i in $(seq 2 100)
do
        cp $NGX_FILE_DIR/conf1.conf $NGX_FILE_DIR/conf$i.conf
done

# generate lighttpd files
for i in $(seq 1 100)
do
        echo "this is content of file$i" > $LIGHTTPD_FILE_DIR/file$i.txt
done

# generate secret files
for i in $(seq 1 100)
do
        echo "this is secret content of secret file_f$i" > $SECRET_FILE_DIR/secret_f$i.txt
done