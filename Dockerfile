FROM alpine:latest

ENV UUID=uuid VER=4.19.1 ROOT_PASSWORD=alpine SSPASS=sspass UU1ID=uuid1 UU2ID=uuid2 UU3ID=uuid3 UU4ID=uuid4 UU5ID=uuid5 UU6ID=uuid6

RUN apk add --no-cache --virtual .build-deps busybox bash ca-certificates curl openssh-server openssh-sftp-server tzdata nano \
 && ssh-keygen -A \
 && mkdir -m 755 /etc/v2ray \
 && mkdir -m 755 /etc/caddy \
 && mkdir -m 755 /etc/caddy/www \
 && mkdir -m 755 /usr/bin/v2ray \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
 && echo "Asia/Shanghai" > /etc/timezone
 
RUN wget -O /tmp/v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
  &&  unzip /tmp/v2ray.zip "v2ray" -d /usr/bin/v2ray/ \
  &&  unzip /tmp/v2ray.zip "v2ctl" -d /usr/bin/v2ray/  \
  &&  unzip /tmp/v2ray.zip "geosite.dat" -d /usr/bin/v2ray/ \
  &&  unzip /tmp/v2ray.zip "geoip.dat" -d /usr/bin/v2ray/ \
  &&  rm -rf /tmp/v2ray.zip \
  &&  chmod +x /usr/bin/v2ray/v2ray \
  &&  chmod +x /usr/bin/v2ray/v2ctl

RUN wget -O /tmp/caddy_install.sh https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/caddy_install.sh \
  && chmod +x /tmp/caddy_install.sh \
  && bash /tmp/caddy_install.sh
 
ADD files/restart.sh /usr/bin/v2ray/restart.sh
RUN chmod +x /usr/bin/v2ray/restart.sh
ADD files/config.json /etc/v2ray/config.json
ADD files/Caddyfile /etc/caddy/Caddyfile
ADD files/authorized_keys /etc/ssh/authorized_keys
RUN chmod 600 /etc/ssh/authorized_keys
ADD files/sshd_config /etc/ssh/sshd_config
ADD files/index.html /etc/caddy/www/index.html
ADD run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT /run.sh
