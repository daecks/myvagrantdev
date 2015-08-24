#!/bin/bash
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install -y --force-yes git
sudo apt-get install -y --force-yes git-gui
sudo apt-get install -y --force-yes gitk
sudo apt-get install -y --force-yes git-man
git --version

sudo apt-get -y --force-yes install ddd
sudo apt-get -y --force-yes install cscope
sudo apt-get -y --force-yes install ctags
sudo apt-get -y --force-yes install kdiff3
sudo apt-get -y --force-yes install cppcheck

# Lizard install
sudo apt-get -y --force-yes install python-pip
cd /tmp
git clone https://github.com/terryyin/lizard
cd lizard
sudo pip install lizard
pip show lizard
sudo rm -rf /tmp/lizard
# Setting source build_env destroys existing pathing
# So create an entry for lizard in /usr/bin
if [ ! -f /usr/bin/lizard ]; then sudo ln -s /usr/local/bin/lizard /usr/bin/lizard; fi

if [ ! -f /usr/bin/colormake ]; then sudo ln -s /vagrant/setup/colormake /usr/bin/colormake; fi
if [ ! -f /usr/bin/colormake.py ]; then sudo ln -s /vagrant/setup/colormake.py /usr/bin/colormake.py; fi

sudo apt-get install -y --force-yes clang-format-3.6
sudo apt-get -y --force-yes install sysbench


