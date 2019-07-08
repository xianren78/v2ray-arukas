
echo "root:${ROOT_PASSWORD}" | chpasswd

/usr/sbin/sshd
echo "Start sshD Success!"

sed -i "s/uuid/$UUID/g" /etc/v2ray/config.json
sed -i "s/uu1id/$UU1ID/g" /etc/v2ray/config.json
sed -i "s/uu2id/$UU2ID/g" /etc/v2ray/config.json
sed -i "s/uu3id/$UU3ID/g" /etc/v2ray/config.json
sed -i "s/uu4id/$UU4ID/g" /etc/v2ray/config.json
sed -i "s/uu5id/$UU5ID/g" /etc/v2ray/config.json
sed -i "s/uu6id/$UU6ID/g" /etc/v2ray/config.json
sed -i "s/sspass/$SSPASS/g" /etc/v2ray/config.json
cd /tmp
wget --no-check-certificate https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip
unzip v2ray-linux-64.zip v2ray v2ctl geosite.dat geoip.dat -d /usr/bin/v2ray/
if [ ! -f "/usr/bin/v2ray/v2ray" ]; then
 unzip v2ray-linux-64.zip "v2ray-v$VER-linux-64\v2ray" "v2ray-v$VER-linux-64\v2ctl" "v2ray-v$VER-linux-64\geosite.dat" "v2ray-v$VER-linux-64\geoip.dat" -d /usr/bin/v2ray/
fi
rm -rf /tmp/v2ray-linux-64.zip
chmod +x /usr/bin/v2ray/v2ray /usr/bin/v2ray/v2ctl

/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json >/dev/null  2>&1  &
echo "Start v2ray Success!"

wget --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh
/usr/local/caddy/caddy -conf /etc/caddy/Caddyfile >/dev/null  2>&1  &

echo "Start caddy Success!"

sed -i '$i 0       12      *       *       *       cat /dev/null > /etc/v2ray/access.log' /etc/crontabs/root
sed -i '$i 0       12      *       *       *       cat /dev/null > /etc/caddy/caddy.log' /etc/crontabs/root

crond
echo "Start crond Success!"

date >>/etc/caddy/www/host.txt
cat /proc/1/environ |tr '\0' '\n'|grep -E "MARATHON_HOST|MARATHON_PORT_22" >>/etc/caddy/www/host.txt

cd /usr/bin/v2ray
./restart.sh
