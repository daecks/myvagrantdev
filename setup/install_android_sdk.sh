#!/bin/bash
set -e # Bail immediately if any part fails
SDK_DIR=/home/vagrant/Android/Sdk
ANDROID_BIN="${SDK_DIR}/tools/android"
if [ ! -e $ANDROID_BIN ] ; then
    echo "Installing Android SDK"
    TMPFILE=`mktemp`
    PWD=`pwd`
    wget http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz -O $TMPFILE
    tar -xzvf $TMPFILE -C $PWD
    rm $TMPFILE

    sudo rm -rf $SDK_DIR
    mkdir -p $SDK_DIR
    cp -r android-sdk-linux/* $SDK_DIR
    sudo chmod 755 -R $SDK_DIR
    sudo chown vagrant:vagrant -R $SDK_DIR
    rm -rf android-sdk-linux

    sudo apt-get clean

    # android sdk
    #    1- Android SDK Tools, revision 24.3.3
    #    2- Android SDK Platform-tools, revision 22
    #    7- Android SDK Build-tools, revision 21.1.2
    #    26- SDK Platform Android 5.0.1, API 21, revision 2
    #    28- SDK Platform Android 4.4.2, API 19, revision 4
    #    101- Google APIs, Android API 21, revision 1
    #    128- Google APIs Intel x86 Atom System Image, Google Inc. API 21, revision 6
    #    131- Sources for Android SDK, API 21, revision 1
    #    133- Sources for Android SDK, API 19, revision 2
    #    139- Android Support Repository, revision 1
    # README: 2 has to be before 1 ;) - First is Sunday, then is Saturday...

    # Desired version of SDK tools should always be at top of list
    SDK_TOOLS_LATEST=1
    PLATFORM_TOOLS_LATEST=`$ANDROID_BIN list sdk --all | grep "Platform-tools" | sed 's/-.*//'`
    # Always use latest version of build tools, so get first line (most recent)
    BUILD_TOOLS_LATEST=`$ANDROID_BIN list sdk --all | grep "Build-tools" | sed 's/-.*//' | sed -n '1 p'`
    BUILD_TOOLS_19_1=`$ANDROID_BIN list sdk --all | grep "Build-tools, revision 19.1" | sed 's/-.*//'`
    SDK_PLATFORM_4_4_2=`$ANDROID_BIN list sdk --all | grep "SDK Platform Android 4.4.2" | sed 's/-.*//'`
    API_SOURCES_API19=`$ANDROID_BIN list sdk --all | grep "Sources for Android SDK, API 19" | sed 's/-.*//'`
    SUPPORT_REPOSITORY_LATEST=`$ANDROID_BIN list sdk --all | grep "Android Support Repository" | sed 's/-.*//'`
    GOOGLE_APIS_API19=`$ANDROID_BIN list sdk --all | grep "Google APIs (x86 System Image), Android API 19" | sed 's/-.*//'`
    SYSTEM_IMAGE_API19=`$ANDROID_BIN list sdk --all | grep "Intel x86 Atom System Image, Android API 19" | sed 's/-.*//'`

    # Platform tools first then SDK tools.  No order to remaining tools.
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $PLATFORM_TOOLS_LATEST
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $SDK_TOOLS_LATEST
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $BUILD_TOOLS_19_1
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $BUILD_TOOLS_LATEST
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $SDK_PLATFORM_4_4_2
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $SYSTEM_IMAGE_LATEST
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $GOOGLE_APIS_API19
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $API_SOURCES_API19
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $SUPPORT_REPOSITORY_LATEST

    # setup adb path
    sudo echo export PATH=\$PATH:$SDK_DIR/platform-tools >> /home/vagrant/.bashrc

   echo "Finished installing Android SDK"
else
    echo "Android SDK installation already exists"
fi
