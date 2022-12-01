#!/bin/bash

set -ex

HAPROXY_MAJOR_VERSION="2.6"
HAPROXY_MINOR_VERSION="6"

TAR_FILE="haproxy-$HAPROXY_MAJOR_VERSION.$HAPROXY_MINOR_VERSION.tar.gz"
DIR_NAME="haproxy-$HAPROXY_MAJOR_VERSION.$HAPROXY_MINOR_VERSION"


HAPROXY_FULLPATH="/usr/local/sbin/haproxy"

# Preparation destinations
PREP_HAPROXY_CFG="/tmp/haproxy.cfg"
PREP_HAPROXY_BACKEND_CFG="/tmp/backend.cfg"
PREP_HAPROXY_SYSTEMD_CFG="/tmp/haproxy.service"
PREP_HAPROXY_RSYSLOG_CFG="/tmp/99-haproxy.conf"

# prod destinations
HAPROXY_CFG="/etc/haproxy/haproxy.cfg"
HAPROXY_BACKEND_CFG="/etc/haproxy/backend.cfg"
HAPROXY_SYSTEMD_CFG="/usr/lib/systemd/system/haproxy.service"
HAPROXY_RSYSLOG_CFG="/etc/rsyslog.d/99-haproxy.conf"

echo "--- Installing prerequisites"
sudo yum install -y gcc systemd-devel

echo "--- Fetching haproxy"
cd /tmp
wget -v http://www.haproxy.org/download/$HAPROXY_MAJOR_VERSION/src/$TAR_FILE
ls -l

echo "--- Preparing haproxy source"
tar -zxf /tmp/$TAR_FILE
cd haproxy-$HAPROXY_MAJOR_VERSION.$HAPROXY_MINOR_VERSION
ls -l

echo "--- Building and installing haproxy"
make clean || true
make -j $(nproc) TARGET=linux-glibc USE_LINUX_TPROXY=1 USE_SYSTEMD=1
sudo make install

echo "Haproxy installed."

echo "--- Setting up haproxy config"

cat >$PREP_HAPROXY_CFG <<EOF
global
    log             127.0.0.1:514 local0
    maxconn         4000
    user            haproxy
    group           haproxy
    stats socket    127.0.0.1:8000 expose-fd listeners level user
    daemon

defaults
    log     global
    option  tcplog
    mode    tcp
    timeout connect 5000ms
    timeout client  50000ms
    timeout server  50000ms

frontend  tproxy
    bind            127.0.0.1:7331 transparent
    default_backend tcpserver
EOF

cat >$PREP_HAPROXY_BACKEND_CFG <<EOF
backend tcpserver
    balance     roundrobin
    server      one 10.0.98.93:1337 send-proxy-v2 check
    server      two 10.0.64.116:1337 send-proxy-v2 check
EOF

echo "--- Setup haproxy.service in systemd"
cat >$PREP_HAPROXY_SYSTEMD_CFG <<EOF
[Unit]
Description=HAProxy
Documentation=man:haproxy(1)
After=network.target

[Service]
Environment='CONFIG=/etc/haproxy/' PIDFILE='/var/run/haproxy.pid'
ExecStartPre=/usr/local/sbin/haproxy -f \$CONFIG -c -q
ExecStart=/usr/local/sbin/haproxy -Ws -f \$CONFIG -p \$PIDFILE -d
ExecReload=/usr/local/sbin/haproxy -f \$CONFIG -c -q
ExecReload=/bin/kill -USR2 \$MAINPID
KillMode=mixed
Restart=always
SuccessExitStatus=143
Type=notify

[Install]
WantedBy=multi-user.target
EOF

cat >$PREP_HAPROXY_RSYSLOG_CFG <<EOF
\$ModLoad imudp
\$UDPServerAddress 127.0.0.1
\$UDPServerRun 514

local0.* /var/log/haproxy.log
local0.notice /var/log/haproxy-admin.log
EOF

sudo useradd --system --shell=/sbin/nologin haproxy
sudo mkdir -p /etc/haproxy
sudo mv -f $PREP_HAPROXY_CFG $HAPROXY_CFG
sudo mv -f $PREP_HAPROXY_BACKEND_CFG $HAPROXY_BACKEND_CFG
sudo chown -R haproxy:haproxy /etc/haproxy

sudo mv -f $PREP_HAPROXY_RSYSLOG_CFG $HAPROXY_RSYSLOG_CFG

sudo mv -f $PREP_HAPROXY_SYSTEMD_CFG $HAPROXY_SYSTEMD_CFG
sudo systemctl enable haproxy
