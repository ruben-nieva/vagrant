#!/usr/bin/env bash

echo "Installing Puppet Server ........ please wait"
cd /tmp
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update > /dev/null 2>&1
apt-get install -y puppetmaster > /dev/null 2>&1

#Commet out a deprecated line
sed -e '/templatedir/s/^#*/#/' -i /etc/puppet/puppet.conf

#Add to /etc/hosts
#echo "172.28.128.3  puppetserver.cba.corp.globant.com puppetserver" >> /etc/hosts
#echo "172.28.128.4  graylog-mongo01.cba.corp.globant.com    graylog-mongo01" >> /etc/hosts
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
echo "172.28.128.32  graylog-server02.cba.corp.globant.com  graylog-server01" >> /etc/hosts
echo "172.28.128.33  graylog-server03.cba.corp.globant.com  graylog-server01" >> /etc/hosts

#Autosign config
echo '*.corp.globant.com' > /etc/puppet/autosign.conf
#/usr/bin/puppet config set autosign true --section master
#/usr/bin/puppet resource service iptables ensure=stopped enable=false
/usr/bin/puppet resource service puppetmaster ensure=running enable=true

#Download puppet modules
puppet module install puppetlabs-stdlib
#puppet module install puppetlabs-apt
#puppet module install puppetlabs-java
puppet module install elasticsearch-elasticsearch
puppet module install puppetlabs-mongodb
#puppet module install puppet-archive
puppet module install tylerwalts-jdk_oracle
#puppet module install spantree-java8
puppet module install graylog-graylog

# symlink manifest from Vagrant synced folder location
ln -s /vagrant/manifests/site.pp /etc/puppet/manifests/site.pp
#ln -s /vagrant/manifests/nodes.pp /etc/puppet/manifests/nodes.pp

#End script
