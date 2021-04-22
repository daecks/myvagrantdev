#!/bin/bash

# Force symlink of .tmux.conf
if ! [ -L /home/vagrant/.tmux.conf ]; then
    # Remove non-symlinked file
    rm -f /home/vagrant/.tmux.conf
    ln -s /vagrant/setup/.tmux.conf /home/vagrant/.tmux.conf
fi

SUPPORTED_VERSION=2.8
INSTALLED_VERSION=`tmux -V`

if [[ $INSTALLED_VERSION != *$SUPPORTED_VERSION* ]]; then
    sudo apt-get -qq remove tmux
    sudo apt-get -qq install wget tar libevent-dev libncurses-dev
    wget https://github.com/tmux/tmux/releases/download/${SUPPORTED_VERSION}/tmux-${SUPPORTED_VERSION}.tar.gz
    tar xf tmux-${SUPPORTED_VERSION}.tar.gz
    rm -f tmux-${SUPPORTED_VERSION}.tar.gz
    cd tmux-${SUPPORTED_VERSION}
    ./configure
    make -j$(nproc)
    sudo make install
    cd -
    sudo rm -rf /usr/local/src/tmux-*
    sudo mv tmux-${SUPPORTED_VERSION} /usr/local/src
else
    echo "You have the supported version ($SUPPORTED_VERSION) of tmux installed"
fi

