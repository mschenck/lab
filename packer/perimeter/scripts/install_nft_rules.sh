#!/bin/bash

set -ex

NFT_FULLPATH="/usr/local/sbin/nft"
NFT="sudo $NFT_FULLPATH"

# Preparation destinations
PREP_NFT_SCRIPT="/tmp/inet-tproxy.nft"
PREP_NFT_ENTRY_CFG="/tmp/nftables.conf"
PREP_NFT_SYSTEMD_CFG="/tmp/nftables.service"

# prod destinations
NFT_SCRIPT="/etc/nftables/inet-tproxy.nft"
NFT_ENTRY_CFG="/etc/sysconfig/nftables.conf"
NFT_SYSTEMD_CFG="/usr/lib/systemd/system/nftables.service"

echo "--- Apply tproxy ruleset"
$NFT add table inet edgeports
$NFT add chain inet edgeports proxy { type filter hook input priority 0 \; policy accept \; }
$NFT add rule inet edgeports proxy meta iifname "lo" return
$NFT add rule inet edgeports proxy meta iifname "eth0" return
$NFT add rule inet edgeports proxy meta l4proto tcp tproxy ip to 127.0.0.1:7331
$NFT add rule inet edgeports proxy meta l4proto tcp tproxy ip6 to ::1:7331

echo "--- Create tproxy.nft script"
echo $(printf '#!' ; printf $NFT_FULLPATH) > $PREP_NFT_SCRIPT
echo >> $PREP_NFT_SCRIPT
$NFT list ruleset inet >> $PREP_NFT_SCRIPT

echo "--- Add nftables config"
cat > $PREP_NFT_ENTRY_CFG <<EOF
# Inet Tproxy
include "./$NFT_SCRIPT"
EOF

echo "--- Setup nftables.service in systemd"
cat > $PREP_NFT_SYSTEMD_CFG <<EOF
[Unit]
Description=Netfilter Tables
Documentation=man:nft(8)
Wants=network-pre.target
Before=network-pre.target

[Service]
Type=oneshot
ProtectSystem=full
ProtectHome=true
ExecStart=$NFT_FULLPATH -f /etc/sysconfig/nftables.conf
ExecReload=$NFT_FULLPATH 'flush ruleset; include "/etc/sysconfig/nftables.conf";'
ExecStop=$NFT_FULLPATH flush ruleset
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

sudo mkdir /etc/nftables
sudo mv -f $PREP_NFT_SCRIPT $NFT_SCRIPT
sudo mv -f $PREP_NFT_ENTRY_CFG $NFT_ENTRY_CFG
sudo mv -f $PREP_NFT_SYSTEMD_CFG $NFT_SYSTEMD_CFG
sudo systemctl enable nftables
