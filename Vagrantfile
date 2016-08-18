# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  #config.vm.box = "ubuntu/trusty64"

  # config.vm.synced_folder "../data", "/vagrant_data"

## Setup for Puppet server
        config.vm.define "puppet" do |puppet|
                puppet.vm.hostname = "puppetserver"
                puppet.vm.box = "ubuntu/trusty64"
                #puppet.vm.network "private_network", type: "dhcp"
                puppet.vm.network "private_network", ip: "172.28.128.3"
                puppet.vm.provision "shell", path: "provision-server.sh"
        end

## Setup for Puppet client
        config.vm.define "mongo01" do |mongo01|
                mongo01.vm.hostname = "graylog-mongo01"
                mongo01.vm.box = "ubuntu/trusty64"
                mongo01.vm.network "private_network", ip: "172.28.128.4"
                #desktop.vm.network "private_network", type: "dhcp"
                mongo01.vm.provision "shell", path: "provision-agent.sh"
        end

end
