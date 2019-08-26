#!/bin/bash
# Force symlink of .tmux.conf
if ! [ -L /home/vagrant/.tmux.conf ]; then
    # Remove non-symlinked file
    rm /home/vagrant/.tmux.conf
    ln -s /vagrant/apps/.tmux.conf /home/vagrant/.tmux.conf
fi

VERSION=2.6
sudo apt-get -y remove tmux
sudo apt-get -y install wget tar libevent-dev libncurses-dev
wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
tar xf tmux-${VERSION}.tar.gz
rm -f tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./configure
make
sudo make install
cd -
sudo rm -rf /usr/local/src/tmux-*
sudo mv tmux-${VERSION} /usr/local/src
