# !/bin/bash

WORK_DIR=`pwd`
SUBJECT="<An Email>"
CONTENT="Default content of email."
ATTACHMENT=$WORK_DIR/attach1.txt
TO_REMOTE='remote'

MAIL_ADDR="chuqi@junzeng-OptiPlex-5060.test.local"

while getopts "s:c:a:r" arg; do
    case $arg in
        s)
            SUBJECT="$OPTARG";;
        c)
            CONTENT="$OPTARG";;
        a)
            ATTACHMENT="$OPTARG";;
        ?)
            echo "Usage: `basename $0` [options]"
            exit 1
    esac
done

if [[ $TO_REMOTE == '' ]]; then
    echo "sendmail to localhost."
    echo "$CONTENT" | mutt chuqiz@chuqiz-OptiPlex-7080.test.local -s $SUBJECT -a $ATTACHMENT
else
    echo "sendmail to remote"
    echo "$CONTENT" | mutt $MAIL_ADDR -s $SUBJECT -a $ATTACHMENT
fi
