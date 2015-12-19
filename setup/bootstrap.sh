#!/bin/bash
/vagrant/setup/install_git.sh

sudo apt-get -y --force-yes install ddd
sudo apt-get -y --force-yes install cscope
sudo apt-get -y --force-yes install ctags
sudo apt-get -y --force-yes install kdiff3
sudo apt-get -y --force-yes install cppcheck
sudo apt-get install -y --force-yes clang-format-3.6
sudo apt-get -y --force-yes install sysbench

/vagrant/setup/install_vim.sh
