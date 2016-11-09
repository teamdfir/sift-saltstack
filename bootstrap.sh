#!/bin/bash

echo "==> Installing salt-minion"
apt-get install -y software-properties-common
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get install -y salt-minion

echo "==> Making sure salt-minion is dead"
rm -f /etc/salt/minion
service salt-minion stop

echo "==> Basic salt-minion configuration"
echo "sift_version: dev" > /etc/salt/grains

echo "==> Initial bootstrap complete"
echo ""
echo "sudo salt-call --local state.apply"
