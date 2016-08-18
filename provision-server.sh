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
echo "172.28.128.3  puppetserver.cba.corp.globant.com puppetserver" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.4  graylog-mongo01.cba.corp.globant.com    graylog-mongo01" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.5  graylog-mongo02.cba.corp.globant.com    graylog-mongo02" | sudo tee --append /etc/hosts 2> /dev/null
echo "172.28.128.6  graylog-mongo03.cba.corp.globant.com    graylog-mongo03" | sudo tee --append /etc/hosts 2> /dev/null

#Autosign config
echo '*.corp.globant.com' > /etc/puppet/autosign.conf
#/usr/bin/puppet config set autosign true --section master
#/usr/bin/puppet resource service iptables ensure=stopped enable=false
/usr/bin/puppet resource service puppetmaster ensure=running enable=true

#Download puppet modules
puppet module install -i /etc/puppet/modules puppetlabs-stdlib
puppet module install -i /etc/puppet/modules puppetlabs-apt
puppet module install -i /etc/puppet/modules elasticsearch-elasticsearch
puppet module install -i /etc/puppet/modules puppetlabs-mongodb

# symlink manifest from Vagrant synced folder location
ln -s /vagrant/manifests/site.pp /etc/puppet/manifests/site.pp
ln -s /vagrant/manifests/nodes.pp /etc/puppet/manifests/nodes.pp

#End script
