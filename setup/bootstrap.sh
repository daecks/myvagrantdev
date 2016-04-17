#!/bin/bash
/vagrant/setup/install_git.sh

sudo apt-get -y --force-yes install ddd
sudo apt-get -y --force-yes install cscope
sudo apt-get -y --force-yes install ctags
sudo apt-get -y --force-yes install kdiff3
sudo apt-get -y --force-yes install cppcheck
sudo apt-get -y --force-yes install clang-format-3.6
sudo apt-get -y --force-yes install sysbench

# Bookclub
/vagrant/setup/install_seven_languages_book.sh

# Install command line fixer
#cd /home/vagrant
#wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0
#

# Android Development environment setup
# main tools
sudo apt-get -y --force-yes install git gnupg flex bison gperf build-essential
sudo apt-get -y --force-yes install zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev
sudo apt-get -y --force-yes install libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386
sudo apt-get -y --force-yes install libgl1-mesa-dev g++-multilib mingw32 tofrodos
sudo apt-get -y --force-yes install python-markdown libxml2-utils xsltproc zlib1g-dev:i386
sudo apt-get -y --force-yes install libswitch-perl
sudo rm -rf /usr/lib/i386-linux-gnu/libGL.so
sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

# Install Android environment tools
/vagrant/setup/install_java6.sh
/vagrant/setup/install_java7.sh
/vagrant/setup/install_android_studio.sh
/vagrant/setup/install_android_sdk.sh
/vagrant/setup/install_better_git_bash_prompt.sh

# Save best till last
/vagrant/setup/install_vim.sh
