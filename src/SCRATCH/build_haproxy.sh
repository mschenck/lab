#!/bin/bash

set -e

HAPROXY_MAJOR_VERSION="2.6"
HAPROXY_MINOR_VERSION="6"

TAR_FILE="haproxy-$HAPROXY_MAJOR_VERSION.$HAPROXY_MINOR_VERSION.tar.gz"
DIR_NAME="haproxy-$HAPROXY_MAJOR_VERSION.$HAPROXY_MINOR_VERSION"


sudo yum install -y gcc

if [ ! -f /tmp/$TAR_FILE ]
then
	wget http://www.haproxy.org/download/$HAPROXY_MAJOR_VERSION/src/$TAR_FILE -O /tmp/$TAR_FILE
fi

cd /tmp

if [ ! -d $DIR_NAME ]
then
	tar -zxvf /tmp/haproxy-$HAPROXY_MAJOR_VERSION.$HAPROXY_MINOR_VERSION.tgz
fi

cd haproxy-$HAPROXY_MAJOR_VERSION.$HAPROXY_MINOR_VERSION

if [ ! -f /usr/local/sbin/haproxy ]
then
	make clean
	make -j $(nproc) TARGET=linux-glibc USE_LINUX_TPROXY=1
	sudo make install
fi

# haproxy
sudo killall haproxy || true
sudo cat > /etc/haproxy/haproxy.cfg <<EOF
global
    log 127.0.0.1:514  local0
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon


defaults
    log global
    option tcplog
    mode tcp
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend  main
    bind 			127.0.0.1:7331 transparent
    default_backend             tcpserver

backend tcpserver
    balance     roundrobin
    server      static 44.208.159.227:1337 send-proxy check
    #server      static 172.20.169.126:1338 send-proxy-v2 check
EOF
sudo /usr/local/sbin/haproxy -f /etc/haproxy/haproxy.cfg

# iptables
sudo iptables -t mangle -F
sudo iptables -t mangle -I PREROUTING \
     -d 10.0.19.197/32 -p tcp \
     -j TPROXY --on-port=7331 --on-ip=127.0.0.1