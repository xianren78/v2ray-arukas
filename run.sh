rm -f /etc/motd
cat >>/etc/motd <<EOF
Alpine Linux Version : $(cat /etc/alpine-release)
Kernel Version : $(uname -r)
Hostname : $(uname -n)
Enjoy your Docker-Linux Node!
EOF

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
#cd /tmp
#wget -O v2ray.zip http://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip
#unzip v2ray.zip "v2ray" -d /usr/bin/v2ray/
#unzip v2ray.zip "v2ctl" -d /usr/bin/v2ray/
#unzip v2ray.zip "geosite.dat" -d /usr/bin/v2ray/
#unzip v2ray.zip "geoip.dat" -d /usr/bin/v2ray/

#if [ ! -f "/usr/bin/v2ray/v2ray" ]; then
# unzip v2ray.zip "v2ray-v$VER-linux-64\v2ray" -d /usr/bin/v2ray/
# unzip v2ray.zip "v2ray-v$VER-linux-64\v2ctl" -d /usr/bin/v2ray/
# unzip v2ray.zip "v2ray-v$VER-linux-64\geosite.dat" -d /usr/bin/v2ray/
# unzip v2ray.zip "v2ray-v$VER-linux-64\geoip.dat" -d /usr/bin/v2ray/
#fi
#rm -rf /tmp/v2ray.zip
#cd /usr/bin/v2ray
#chmod +x v2ray v2ctl
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json >/dev/null  2>&1  &
echo "Start v2ray Success!"

#cd /tmp
#wget --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh
/usr/local/caddy/caddy -conf /etc/caddy/Caddyfile >/dev/null  2>&1  &

echo "Start caddy Success!"

sed -i '$i 0       12      *       *       *       cat /dev/null > /etc/v2ray/access.log' /etc/crontabs/root
sed -i '$i 0       12      *       *       *       cat /dev/null > /etc/caddy/caddy.log' /etc/crontabs/root

crond
echo "Start crond Success!"

cd /usr/bin/v2ray
./restart.sh