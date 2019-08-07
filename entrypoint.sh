#! /bin/sh

set -e

# Variables
U_ID=${U_ID:=0}
G_ID=${G_ID:=0}
SECRET=${SECRET:=""}
GEN_TRACKER=${GEN_TRACKER:=""}

D_DOWNLOADS=/app/downloads
D_SESSION=/app/session
D_CONF=/app/conf

mkdir -p /app/
mkdir -p $D_CONF
mkdir -p $D_SESSION
mkdir -p $D_DOWNLOADS
touch $D_SESSION/aria2.session

## trackers
if test "$GEN_TRACKER" = "true"; then
    trackers=`curl https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt`
    #trackers=${trackers// /,/}
    trackers=$(echo $trackers | sed 's/ /,/g')
    #sed -i '$a'"bt-tracker=$trackers" $D_CONF/aria2.conf
fi

## aria2.config
cat > $D_CONF/aria2.conf << EOF
## RPC
enable-rpc=true
rpc-listen-port=6800
rpc-allow-origin-all=true
rpc-listen-all=true
rpc-secret=$SECRET

## Session
save-session=$D_SESSION/aria2.session
input-file=$D_SESSION/aria2.session
save-session-interval=20

## Download
dir=$D_DOWNLOADS
max-concurrent-downloads=20
max-connection-per-server=10
min-split-size=20M
split=10
lowest-speed-limit=0

## Other
daemon=false
disk-cache=16M
# none，prealloc，trunc，falloc
file-allocation=falloc

## BT
bt-request-peer-speed-limit=10485760
bt-tracker=$trackers
EOF

## sudo
sed -i 's/root ALL=(ALL) ALL/root ALL=(ALL:ALL) ALL/' /etc/sudoers
chown ${U_ID}:${G_ID} /app -R
sudo -u '#'$U_ID -g '#'$G_ID /usr/bin/aria2c --conf-path=$D_CONF/aria2.conf
