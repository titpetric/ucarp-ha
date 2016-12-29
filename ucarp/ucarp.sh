#!/bin/bash
set -e

[ -z "$VHID" ] && VHID=`printf '%d' 0x$(echo $VIP | md5sum |cut -b1-2)`
echo "Using id: $VHID"

NET=`ip addr show dev $DEV|awk '/inet[^6]/ {print $2}'`
RIP=`echo $NET|cut -d/ -f1`

echo "REAL IP of UCARP instance: $RIP"

exec ucarp -i "$DEV" -s "$RIP" -v "$VHID" -p "$PASS" -a "$VIP" -x "$IPS" -x "$IPDEV" -u /ucarp/up.sh -d /ucarp/down.sh -z --deadratio=5
