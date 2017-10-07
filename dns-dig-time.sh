#!/bin/bash

if test -z "$1" ; then
    echo "You need to supply a DNS server to check. Quitting"
    exit 0;
fi
COUNTER=0
DOMAIN=$1
LC=1.99
HC=4.99
while [  $COUNTER -lt 5 ];
	do
	ts=$(date +%s%N) ; dig $DOMAIN  q-type A 2>&1| grep real | cut -dm -f 2 | sed -e 's/[s.]//g' ; MYTIME=$((($(date +%s%N) - $ts)/1000000))
	#MYTIME=$((time dig $DOMAIN  q-type A) 2>&1| grep real | cut -dm -f 2 | sed -e 's/[s.]//g')
	if [ $? -eq 0 ]; then
		INTERFACE=$(/usr/sbin/route | grep default | awk '{print "interface:" $8}')
		NETWORK=$(/usr/sbin/route | grep `/usr/sbin/route | grep default | awk '{print $8}'` | grep -v default | awk '{print $1}')
		WARN_COLOR=${MYTIME%,*}
		echo `date +%s`" "${1}" "$MYTIME" "$INTERFACE" Network: "$NETWORK >> /var/log/dns-query.log
	else
    		echo 0
	fi
	/usr/bin/tput sgr0
	WARN_COLOR=0
	let COUNTER=COUNTER+1
	sleep 6
done
