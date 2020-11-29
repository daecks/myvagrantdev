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

sudo apt-get install -qq python3-dev python3-pip python3-setuptools
sudo apt-get install -qq python-setuptools
sudo -H pip install wheel
sudo apt-get install -qq snapd

sudo apt-get -qq install cppcheck
sudo apt-get -qq install ddd
sudo apt-get -qq install git
sudo apt-get -qq install htop
sudo apt-get -qq install kdiff3
sudo apt-get -qq install sysbench
sudo apt-get -qq install tree
sudo apt-get -qq install ctags
sudo apt-get -qq install shellcheck
sudo apt-get -qq install openjdk-11-jdk

sudo snap install android-studio --classic
sudo snap install intellij-idea-community --classic --edge
sudo snap install pycharm-community --classic
sudo snap install code --classic
#sudo snap install node --classic --channel=12 #Disabled until Virtualbox interaction fix
sudo snap install go --classic
sudo snap install tldr --classic

wget https://raw.githubusercontent.com/GitAlias/gitalias/master/gitalias.txt -O /home/vagrant/.gitalias.txt

/vagrant/setup/install_powerline_shell.sh
/vagrant/setup/install_cd_dash_dash.sh
/vagrant/setup/install_bat.sh
/vagrant/setup/install_fzf.sh
/vagrant/setup/install_ripgrep.sh
/vagrant/setup/install_fortunes.sh
/vagrant/setup/install_docker_ce.sh
/vagrant/setup/install_hexyl.sh
/vagrant/setup/install_pidcat.sh
/vagrant/setup/install_pyenv.sh
/vagrant/setup/install_seven_languages_book.sh
/vagrant/setup/install_tmux.sh
/vagrant/setup/install_mono.sh
/vagrant/setup/install_rust.sh
sudo pip3 install thefuck
/vagrant/setup/install_vim.sh

# KVM installation https://developer.android.com/studio/run/emulator-acceleration?utm_source=android-studio#vm-linux)
# But without ubuntu-vm-builder, which is not available in linux mint.
sudo apt-get -qq install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils ia32-libs-multiarch
sudo adduser $USER kvm

cp /var/lib/snapd/desktop/applications/*.desktop /home/vagrant/Desktop
sudo chmod +x /home/vagrant/Desktop/*.desktop
sudo chown vagrant /home/vagrant/Desktop/*.desktop

sudo apt-get -qq autoremove
