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
echo "172.28.128.10  puppetserver.cba.corp.globant.com puppetserver" | sudo tee --append /etc/hosts 2> /dev/null
#Mongodb Servers
echo "172.28.128.11  graylog-mongo01.cba.corp.globant.com   graylog-mongo01" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.12 graylog-mongo02.cba.corp.globant.com    graylog-mongo02" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.13  graylog-mongo03.cba.corp.globant.com   graylog-mongo03" | sudo tee --append /etc/hosts 2> /dev/null
#Elasticsearch
echo "172.28.128.21  graylog-elasticsearch01.cba.corp.globant.com  graylog-elasticsearch01" >> /etc/hosts
echo "172.28.128.22  graylog-elasticsearch02.cba.corp.globant.com  graylog-elasticsearch02" >> /etc/hosts
echo "172.28.128.23  graylog-elasticsearch03.cba.corp.globant.com  graylog-elasticsearch03" >> /etc/hosts
#Graylog Servers
echo "172.28.128.31  graylog-server01.cba.corp.globant.com  graylog-server01" >> /etc/hosts
echo "172.28.128.32  graylog-server02.cba.corp.globant.com  graylog-server02" >> /etc/hosts
echo "172.28.128.33  graylog-server03.cba.corp.globant.com  graylog-server03" >> /etc/hosts
#Graylog Webs
echo "172.28.128.41  graylog-web01.cba.corp.globant.com  graylog-web01" >> /etc/hosts
echo "172.28.128.42  graylog-web02.cba.corp.globant.com  graylog-web02" >> /etc/hosts
echo "172.28.128.43  graylog-web03.cba.corp.globant.com  graylog-web03" >> /etc/hosts

#Client config
puppet config set --section main server  puppetserver.cba.corp.globant.com
#Change the agent interval to check-in
puppet config set --section agent runinterval  240
sed -i 's/START=no/START=yes/g' /etc/default/puppet
puppet resource service puppet ensure=running enable=true
puppet agent --enable
#Force the first connection with the master
#puppet agent -t --verbose
