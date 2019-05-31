#!/bin/bash

while [ 1 ] ; do
  if [ $(ps | grep "v2ray" | grep -v "grep" | wc -l) -eq 0 ]
  then
  rm -rf /etc/v2ray/ss-loop*
  /usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json >/dev/null  2>&1  &
  echo "Restart v2ray Success!"
  fi
  echo "v2ray is running!"
  sleep 60s
done