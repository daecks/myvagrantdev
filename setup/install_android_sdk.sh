#!/bin/bash
set -e # Bail immediately if any part fails
ANDROID_DIR=/home/vagrant/Android
SDK_DIR="${ANDROID_DIR}/Sdk"
if [ ! -e $SDK_DIR ] ; then
    echo "Installing Android SDK to $SDK_DIR"
    TMPFILE=`mktemp`
    PWD=`pwd`
    wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O $TMPFILE
    unzip $TMPFILE -d $SDK_DIR
    sudo chmod 755 -R $ANDROID_DIR
    sudo chown vagrant:vagrant -R $ANDROID_DIR
    echo "Finished installing Android SDK to $SDK_DIR"
else
    echo "Android SDK installation already exists in $SDK_DIR"
fi

