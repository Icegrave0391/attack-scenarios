
# ./sendemail.sh  title  content   attachment  

if [ $# -lt 3 ]; then
    echo "Usage: ./send_email.sh email_subject email_content attachment_path"
    exit 1
fi

TITLE=$1
CONTENT=$2
ATTACHMENT=$3


if [[ $4 == '' ]]; then
    echo "sendmail to localhost."
    echo "$CONTENT" | mutt chuqiz@chuqiz-OptiPlex-7080.test.local -s $TITLE -a $ATTACHMENT
else
    echo "sendmail to remote"
    echo "$CONTENT" | mutt chuqi@junzeng-OptiPlex-5060.test.local -s $TITLE -a $ATTACHMENT
fi
