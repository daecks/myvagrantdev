#!/bin/bash

# General info: http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin

# Assumes .bashrc contains the following:
# set xterm-color256
#function _update_ps1() {
#    PS1="$(~/powerline-shell.py $? 2> /dev/null)"
#}
#
#if [ "$TERM" != "linux" ]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

# Install Powerline
#Reference https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
sudo apt install -qq python-pip
sudo apt install -qq python-setuptools
sudo -H pip install wheel
sudo apt-get -qq install fonts-powerline

cd /tmp
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
sudo python setup.py install

# Update git colors to match powerline-shell color scheme
git config --global color.status.untracked 009 
git config --global color.status.changed 214 
git config --global color.status.unmerged 203 
