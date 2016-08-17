#!/usr/bin/env bash

echo "Installing Puppet Server ........ please wait"
cd /tmp
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update > /dev/null 2>&1
apt-get install -y puppet > /dev/null 2>&1

#Comment out a deprecated line
sed -e '/templatedir/s/^#*/#/' -i /etc/puppet/puppet.conf

#Add to /etc/hosts
echo "172.28.128.3  puppetserver.cba.corp.globant.com puppetserver" >> /etc/hosts
echo "172.28.128.4  desktop.cba.corp.globant.com    desktop" >> /etc/hosts

#Client config
puppet config set --section main server  puppetserver.cba.corp.globant.com
sed -i 's/START=no/START=yes/g' /etc/default/puppet
puppet resource service puppet ensure=running enable=true
puppet agent --enable
#puppet agent -t
