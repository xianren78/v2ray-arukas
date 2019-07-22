FROM debian:stretch-slim

ENV UUID=uuid VER=4.19.1 ROOT_PASSWORD=alpine SSPASS=sspass UU1ID=uuid1 UU2ID=uuid2 UU3ID=uuid3 UU4ID=uuid4 UU5ID=uuid5 UU6ID=uuid6

RUN apt-get update && apt-get -y install --no-install-recommends wget ca-certificates openssh-server openssh-sftp-server unzip vim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && ssh-keygen -A \
 && mkdir /run/sshd \
 && mkdir -m 755 /etc/v2ray \
 && mkdir -m 755 /etc/caddy \
 && mkdir -m 755 /etc/caddy/www \
 && mkdir -m 755 /usr/bin/v2ray \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo "Asia/Shanghai" > /etc/timezone
 
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
