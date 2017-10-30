#!/bin/sh

# Works only on FreeBSD!

SERVER=$1
RETVAL=0
TIMESTAMP=`echo | date` # current date

EXPIRE_DATE=`echo | openssl s_client -connect $SERVER:443 -servername $SERVER 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notAfter | cut -d'=' -f2` #when expire
#EXPIRE_SECS=`date -j -f "%b %d %k:%M:%s %Y %Z" "$EXPIRE_DATE" +%s` # when expire in seconds
EXPIRE_SECS=`date -j -f "%b %d %X %Y %Z" "$EXPIRE_DATE" +%s`
EXPIRE_TIME=$(( ${EXPIRE_SECS} - `date +%s` )) # expire in N seconds
if test $EXPIRE_TIME -lt 0
then
RETVAL=0
else
RETVAL=$(( ${EXPIRE_TIME} / 24 / 3600 )) # expire in N days
fi

echo ${RETVAL}