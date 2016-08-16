#!/usr/bin/env bash

echo "Installing Puppet Server ........ please wait"
cd /tmp
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update > /dev/null 2>&1
apt-get install -y puppet > /dev/null 2>&1

#Add to /etc/hosts
echo "172.28.128.3  puppetserver.cba.corp.globant.com puppetserver" >> /etc/hosts
echo "172.28.128.4  desktop.cba.corp.globant.com    desktop" >> /etc/hosts
