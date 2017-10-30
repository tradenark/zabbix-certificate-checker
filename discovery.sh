#!/bin/sh
JSON=$(for i in `cat /usr/local/etc/zabbix32/scripts/ssl/list`; do printf "{\"{#SSL}\":\"$i\"},"; done | sed 's/^\(.*\).$/\1/')
printf "{\"data\":["
printf "$JSON"
printf "]}"