#!/bin/bash

CURRENT_GIT_VERSION=`git --version`
SUPPORTED_GIT_VERSION=2.11.4
GIT_URL="https://github.com/git/git/archive/v${SUPPORTED_GIT_VERSION}.zip"
echo $GIT_URL
echo Current Git version: $CURRENT_GIT_VERSION
echo Supported Git version: $SUPPORTED_GIT_VERSION

if [[ $(git --version) != *$SUPPORTED_GIT_VERSION* ]]; then
    cd /tmp
    echo "This will forcefully install git version $SUPPORTED_GIT_VERSION"
    sudo apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
    wget -N -q $GIT_URL -O git.zip
    unzip -o -qq git.zip
    cd git-*
    make prefix=/usr all
    sudo make prefix=/usr install
    cd $HOME
    git --version
else
    echo "You have the supported version of Git installed"
fi

