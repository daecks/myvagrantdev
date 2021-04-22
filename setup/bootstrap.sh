#!/bin/bash 
# Remove "dpkg-preconfigure: unable to re-open stdin: No such file or directory" 
export DEBIAN_FRONTEND=noninteractive 

sudo apt-get update -qq 

# Use controlled version of .bashrc 
if ! [ -L /home/vagrant/.bashrc ]; then 
    if [ -e /home/vagrant/.bashrc ]; then
        rm /home/vagrant/.bashrc 
    fi 
    ln -s /vagrant/setup/.bashrc /home/vagrant/.bashrc 
fi 

# Setup common dirs
mkdir -p /home/vagrant/bin
sudo chown vagrant:vagrant /home/vagrant/bin

sudo apt-get -qq install cppcheck
sudo apt-get -qq install ddd
sudo apt-get -qq install git
sudo apt-get -qq install htop
sudo apt-get -qq install kdiff3
sudo apt-get -qq install sysbench
sudo apt-get -qq install tree
sudo apt-get -qq install ctags
sudo apt-get -qq install shellcheck
sudo apt-get -qq install golang
sudo apt-get -qq install bat
sudo apt-get -qq install vim
sudo apt-get -qq install dos2unix
sudo apt-get -qq install cmake
sudo apt-get -qq install colordiff

flatpak -y install flathub org.freedesktop.Platform//20.08
flatpak -y install flathub com.google.AndroidStudio
flatpak -y install flathub com.jetbrains.IntelliJ-IDEA-Community
flatpak -y install flathub com.jetbrains.PyCharm-Community
flatpak -y install flathub com.visualstudio.code

# Android stuff
sudo apt-get -qq install libudev-dev # udev rules

# Copy .desktop files from flatpak installs to user desktop
cp /var/lib/flatpak/exports/share/applications/*.desktop /home/vagrant/Desktop/

wget https://raw.githubusercontent.com/GitAlias/gitalias/master/gitalias.txt -O /home/vagrant/.gitalias.txt

/vagrant/setup/install_powerline_shell.sh
/vagrant/setup/install_so.sh
/vagrant/setup/install_cd_dash_dash.sh
/vagrant/setup/install_fzf.sh
/vagrant/setup/install_ripgrep.sh
/vagrant/setup/install_fortunes.sh
#/vagrant/setup/install_docker_ce.sh #Temporarily disabled
/vagrant/setup/install_hexyl.sh
/vagrant/setup/install_pidcat.sh
/vagrant/setup/install_tmux.sh
/vagrant/setup/install_rust.sh
/vagrant/setup/configure_vim.sh

sudo apt-get -qq autoremove
