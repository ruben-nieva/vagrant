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
echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.3  puppetserver.cba.corp.globant.com puppetserver" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.4  graylog-mongo01.cba.corp.globant.com    graylog-mongo01" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.5  graylog-mongo02.cba.corp.globant.com    graylog-mongo02" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.6  graylog-mongo03.cba.corp.globant.com    graylog-mongo03" | sudo tee --append /etc/hosts 2> /dev/null

#Client config
puppet config set --section main server  puppetserver.cba.corp.globant.com
sed -i 's/START=no/START=yes/g' /etc/default/puppet
puppet resource service puppet ensure=running enable=true
puppet agent --enable
#Force the first connection with the master
#puppet agent -t
