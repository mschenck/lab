#!/bin/bash

set -ex

sudo yum install -y gmp-devel libedit-devel iptables-devel jansson-devel libtool flex bison libreadline

cd /tmp
wget https://www.netfilter.org/pub/libmnl/libmnl-1.0.5.tar.bz2
tar -jxf libmnl-1.0.5.tar.bz2
cd libmnl-1.0.5/
./configure
make
make check
sudo make install
cd ..

wget https://www.netfilter.org/pub/libnftnl/libnftnl-1.2.4.tar.bz2
tar -jxf libnftnl-1.2.4.tar.bz2
cd libnftnl-1.2.4/
LIBMNL_LIBS="-L/usr/local/lib -lmnl" LIBMNL_CFLAGS="-I/usr/local/include" ./configure
make
make check
sudo make install
cd ..

wget https://www.netfilter.org/projects/nftables/files/nftables-1.0.5.tar.bz2
tar -jxf nftables-1.0.5.tar.bz2
cd nftables-1.0.5/
LIBMNL_LIBS="-L/usr/local/lib -lmnl" LIBMNL_CFLAGS="-I/usr/local/include" LIBNFTNL_CFLAGS="-I/usr/local/include" LIBNFTNL_LIBS="-L/usr/local/lib -lnftnl" ./configure --with-xtables --with-json  --disable-man-doc
make
make check
sudo make install