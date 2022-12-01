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
    bind                        127.0.0.1:7331 transparent
    default_backend             tcpserver

backend tcpserver
    balance     roundrobin
    #server      static 44.208.159.227:1337 send-proxy check
    server      one 10.0.98.93:1337 send-proxy-v2 check
    server      two 10.0.64.116:1337 send-proxy-v2 check
EOF
sudo /usr/local/sbin/haproxy -f /etc/haproxy/haproxy.cfg

ADDR=$(ip address show dev eth1 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)

# iptables
sudo iptables -t mangle -F
sudo iptables -t mangle -I PREROUTING \
     -d $ADDR/32 -p tcp \
     -j TPROXY --on-port=7331 --on-ip=127.0.0.1

# nftables
# sudo yum install -y nftables

sudo yum install -y gmp-devel libedit-devel iptables-devel jansson-devel libtool flex bison libreadline

cd /tmp
wget https://www.netfilter.org/pub/libmnl/libmnl-1.0.5.tar.bz2
tar -jxf libmnl-1.0.5.tar.bz2
cd libmnl-1.0.5/
./configure
make
make check
make install
cd ..

wget https://www.netfilter.org/pub/libnftnl/libnftnl-1.2.4.tar.bz2
tar -jxf libnftnl-1.2.4.tar.bz2
cd libnftnl-1.2.4/
LIBMNL_LIBS="-L/usr/local/lib -lmnl" LIBMNL_CFLAGS="-I/usr/local/include" ./configure
make
make check
make install
cd ..

wget https://www.netfilter.org/projects/nftables/files/nftables-1.0.5.tar.bz2
tar -jxf nftables-1.0.5.tar.bz2
cd nftables-1.0.5/
LIBMNL_LIBS="-L/usr/local/lib -lmnl" LIBMNL_CFLAGS="-I/usr/local/include" LIBNFTNL_CFLAGS="-I/usr/local/include" LIBNFTNL_LIBS="-L/usr/local/lib -lnftnl" ./configure --with-xtables --with-json  --disable-man-doc
make
make check
make install


cat >/etc/tproxy.nft <<EOF
table inet edgeports {
        chain proxy {
                type filter hook input priority filter; policy accept;
                iifname "eth1"
                meta l4proto tcp tproxy ip to 127.0.0.1:7331
                meta l4proto tcp tproxy ip6 to [::0.1.115.49]
        }
}
EOF

# See [nft (8)](https://www.netfilter.org/projects/nftables/manpage.html)
nft add table inet edgeports
nft add chain inet edgeports proxy { type filter hook input priority 0 \; policy accept \; }
nft add rule inet edgeports proxy meta iifname "lo" return
nft add rule inet edgeports proxy meta iifname "eth0" return
nft add rule inet edgeports proxy meta l4proto tcp tproxy ip to 127.0.0.1:7331
nft add rule inet edgeports proxy meta l4proto tcp tproxy ip6 to ::1:7331
