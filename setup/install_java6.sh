#!/bin/bash
echo "Installing Java 6"
sudo apt-get -y --force-yes install python-software-properties
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y -qq update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y --force-yes install oracle-java6-installer
echo "Finished installing Java 6"