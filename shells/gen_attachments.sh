#!/bin/bash
ATTACHMENT_DIR=/home/chuqiz/attachments

# generate ngx files
for i in $(seq 1 100)
do
        echo "this is content of attachment file$i" > $ATTACHMENT_DIR/attachment$i.txt
done