#!/usr/bin/env bash

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq wget

echo 'export IPFS_PATH=/srv/ipfs' >>~/.bash_profile
source ~/.bash_profile

# ipfs daemon
wget https://dist.ipfs.io/go-ipfs/v0.4.17/go-ipfs_v0.4.17_linux-amd64.tar.gz
tar xvfz go-ipfs_v0.4.17_linux-amd64.tar.gz
rm go-ipfs_v0.4.17_linux-amd64.tar.gz
sudo mv go-ipfs/ipfs /usr/local/bin
rm -rf go-ipfs

# init ipfs
sudo mkdir -p $IPFS_PATH

ipfs init -p server
ipfs config Datastore.StorageMax 100GB
ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/9001

# ipfs systemctl service
sudo bash -c 'cat >/etc/systemd/system/ipfs.service <<EOL
[Unit]
Description=ipfs daemon
[Service]
ExecStart=/usr/local/bin/ipfs daemon --enable-gc
Restart=always
User=ubuntu
Group=ubuntu
Environment="IPFS_PATH=/srv/ipfs"
[Install]
WantedBy=multi-user.target
EOL'

sudo chown -R ubuntu:ubuntu $IPFS_PATH

# enable the new services
sudo systemctl daemon-reload
sudo systemctl enable ipfs.service
sudo service ipfs start
