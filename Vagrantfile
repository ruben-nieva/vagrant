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
                puppet.vm.network "private_network", ip: "172.28.128.10"
                puppet.vm.provision "shell", path: "provision-server.sh"
        end

# Setup for mongoDB servers
         (1..2).each do |i|
           config.vm.define "mongo0#{i}" do |mongo|
             mongo.vm.box = "ubuntu/trusty64"
             mongo.vm.hostname = "graylog-mongo0#{i}"
             mongo.vm.network "private_network", ip: "172.28.128." + (10 + i.to_i).to_s
             mongo.vm.provision "shell", path: "provision-agent.sh"
           end
         end

# elasticsearch
  (1..2).each do |i|
    config.vm.define "elastic0#{i}" do |node|
      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = "graylog-elasticsearch0#{i}"
      node.vm.network "private_network", ip: "172.28.128." + (20 + i.to_i).to_s
      node.vm.network "forwarded_port", guest: 9200, host: "920" + (0 + i.to_i).to_s
      node.vm.provision "shell", path: "provision-agent.sh"
    end
  end

# graylog-server
    (1..2).each do |i|
      config.vm.define "graylog0#{i}" do |node|
        node.vm.box = "ubuntu/trusty64"
        node.vm.hostname = "graylog-server0#{i}"
        node.vm.network "private_network", ip: "172.28.128." + (30 + i.to_i).to_s
        node.vm.provision "shell", path: "provision-agent.sh"
      end
    end


end
