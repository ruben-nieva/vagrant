#!/usr/bin/env bash

#Install Java from Oracle Java PPA
add-apt-repository -y ppa:webupd8team/java
apt-get update > /dev/null 2>&1
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo /usr/bin/debconf-set-selections
#Install the latest stable version of Oracle Java 8 with this command (and accept the license agreement that pops up):
apt-get -y install oracle-java8-installer

#Install Graylog
#cd ~
# wget https://packages.graylog2.org/repo/packages/graylog-1.3-repository-ubuntu14.04_latest.deb
# dpkg -i graylog-1.3-repository-ubuntu14.04_latest.deb
# apt-get update > /dev/null 2>&1
# apt-get install apt-transport-https
# apt-get install graylog-server

#Graylog v.2.x
sudo apt-get install apt-transport-https
wget https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.deb
sudo dpkg -i graylog-2.0-repository_latest.deb
sudo apt-get update > /dev/null 2>&1
sudo apt-get install graylog-server


#Install pwgen, which we will use to generate password secret keys
sudo apt-get install pwgen


#End script
