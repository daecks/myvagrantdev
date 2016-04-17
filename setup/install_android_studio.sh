#!/bin/bash
echo "Installing Android Studio"
echo "Installing Android Studio Java 7 dependency"
sudo apt-get -y --force-yes install openjdk-7-jdk

# Android Studio expects to find Java 7 using STUDIO_JDK env variable
if [ ! -v STUDIO_JDK ]; then
    # Set to java 7 path
    echo export STUDIO_JDK=/usr/lib/jvm/java-7-openjdk-amd64 >> /home/vagrant/.bashrc
fi

sudo add-apt-repository -y ppa:paolorotolo/android-studio
sudo apt-get -y -qq update
sudo apt-get -y --force-yes install android-studio
echo "Finished installing Android Studio"
