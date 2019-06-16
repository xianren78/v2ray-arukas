#!/bin/bash

while [ 1 ] ; do
  if [ $(ps | grep "v2ray" | grep -v "grep" | wc -l) -eq 0 ]
  then
  rm -rf /etc/v2ray/ss-loop*
     if [ ! -f "/usr/bin/v2ray/v2ray" ]; then
      wget --no-check-certificate https://github.com/v2ray/v2ray-core/releases/download/v4.19.1/v2ray-linux-64.zip
      unzip v2ray-linux-64.zip v2ray v2ctl geosite.dat geoip.dat -d /usr/bin/v2ray/
      chmod +x /usr/bin/v2ray/v2ray /usr/bin/v2ray/v2ctl
     fi
  /usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json >/dev/null  2>&1  &
  echo "Restart v2ray Success!"
  fi
  echo "v2ray is running!"
  sleep 60s
done
