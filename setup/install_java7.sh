#!/bin/sh
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y -qq update
sudo apt-get -y --force-yes install oracle-jdk7-installer
