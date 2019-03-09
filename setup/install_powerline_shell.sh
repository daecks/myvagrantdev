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
sudo apt-get -y --force-yes install python-pip
pip install --user powerline-status

# Install Powerline shell
if [ ! -d /home/vagrant/powerline-shell ]; then
    cd /home/vagrant && git clone https://github.com/daecks/powerline-shell
else
    # If exists, update it
    cd /home/vagrant/powerline-shell && git pull
fi

sudo chown vagrant:vagrant -R /home/vagrant/powerline-shell

# Deploy pre-configured settings
cp /home/vagrant/powerline-shell/config.py.dist /home/vagrant/powerline-shell/config.py

# Get the required font patches
cd /home/vagrant
wget -q https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget -q https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
# Location to move font to determined by "xset q" for Linux Mint
sudo mv --force PowerlineSymbols.otf /usr/share/fonts/X11/misc
sudo fc-cache -vf /usr/share/fonts/X11/misc 
[ -d /home/vagrant/.config/fontconfig/conf.d ] || mkdir -p /home/vagrant/.config/fontconfig/conf.d/
sudo mv --force 10-powerline-symbols.conf /home/vagrant/.config/fontconfig/conf.d/
sudo chown vagrant:vagrant -R /home/vagrant/.config/fontconfig/conf.d

# Generate powerline-shell.py for vagrant user
sudo -H -u vagrant bash -c 'cd /home/vagrant/powerline-shell && ./install.py'

# Update git colors to match powerline-shell color scheme
git config --global color.status.untracked 009 
git config --global color.status.changed 214 
git config --global color.status.unmerged 203 
