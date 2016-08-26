#!/usr/bin/env bash

#Install Java from Oracle Java PPA
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update > /dev/null 2>&1
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo /usr/bin/debconf-set-selections
#Install the latest stable version of Oracle Java 8 with this command (and accept the license agreement that pops up):
sudo apt-get -y install oracle-java8-installer

echo "Installing Elasticsearch ........ please wait"
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
apt-get update > /dev/null 2>&1
apt-get -y install elasticsearch > /dev/null 2>&1

#Configure to start at boot time
update-rc.d elasticsearch defaults 95 10

#Configure elasticsearch configuration file
echo "#Init elasticsearch configuration"
echo "cluster.name: elasticsearch" > /etc/elasticsearch/elasticsearch.yml
echo "node.name: ${HOSTNAME}" >> /etc/elasticsearch/elasticsearch.yml
echo "network.host: [${HOSTNAME}, localhost]" >> /etc/elasticsearch/elasticsearch.yml
echo "http.port: 9200" >> /etc/elasticsearch/elasticsearch.yml
echo "discovery.zen.ping.unicast.enabled: false" >> /etc/elasticsearch/elasticsearch.yml
echo "discovery.zen.ping.unicast.hosts: ['graylog-elasticsearch01', 'graylog-elasticsearch02', 'graylog-elasticsearch03']" >> /etc/elasticsearch/elasticsearch.yml
echo "" >> /etc/elasticsearch/elasticsearch.yml
echo "#Configuring shards and replicas" >> /etc/elasticsearch/elasticsearch.yml
echo "#index.number_of_shards: 3" >> /etc/elasticsearch/elasticsearch.yml
echo "#index.number_of_replicas: 1" >> /etc/elasticsearch/elasticsearch.yml


# Install plugin
/usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
/usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ

#Configure to start at boot time
update-rc.d elasticsearch defaults 95 10


#Restart the service
service elasticsearch restart


#End script
