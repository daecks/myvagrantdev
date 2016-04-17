#!/bin/bash
set -e # Bail immediately if any part fails
ANDROID_DIR=/home/vagrant/Android
SDK_DIR="${ANDROID_DIR}/Sdk"
ANDROID_BIN="${SDK_DIR}/tools/android"
if [ ! -e $ANDROID_BIN ] ; then
    echo "Installing Android SDK to $SDK_DIR"
    TMPFILE=`mktemp`
    PWD=`pwd`
    wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O $TMPFILE
    tar -xzvf $TMPFILE -C $PWD
    rm $TMPFILE

    sudo rm -rf $ANDROID_DIR
    mkdir -p $SDK_DIR
    cp -r android-sdk-linux/* $SDK_DIR
    sudo chmod 755 -R $ANDROID_DIR
    sudo chown vagrant:vagrant -R $ANDROID_DIR
    rm -rf android-sdk-linux

    sudo apt-get clean

    # Desired version of SDK tools is listed first
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
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $SYSTEM_IMAGE_API19
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $GOOGLE_APIS_API19
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $API_SOURCES_API19
    echo yes | $ANDROID_BIN update sdk --no-ui -a -t $SUPPORT_REPOSITORY_LATEST

    echo "Finished installing Android SDK to $SDK_DIR"
else
    echo "Android SDK installation already exists in $SDK_DIR"
fi

echo "Updating existing Android SDK installation with new SDK targets"
SDK_PLATFORM_5_1_1=`$ANDROID_BIN list sdk --all | grep "SDK Platform Android 5.1.1" | sed 's/-.*//'`
BUILD_TOOLS_22_0_1=`$ANDROID_BIN list sdk --all | grep "Build-tools, revision 22.0.1" | sed 's/-.*//'`
echo yes | $ANDROID_BIN update sdk --no-ui -a -t $SDK_PLATFORM_5_1_1
echo yes | $ANDROID_BIN update sdk --no-ui -a -t $BUILD_TOOLS_22_0_1
echo "y" | $ANDROID_BIN update sdk --no-ui -a -t android-21
echo "y" | $ANDROID_BIN update sdk --no-ui -a -t build-tools-21.1.2
echo "y" | $ANDROID_BIN update sdk --no-ui -a -t android-23
echo "y" | $ANDROID_BIN update sdk --no-ui -a -t build-tools-23.0.1
echo "y" | $ANDROID_BIN update sdk --no-ui -a -t android-20
echo "y" | $ANDROID_BIN update sdk --no-ui -a -t build-tools-20.0.0

# One more time to ensure permissions are ok
sudo chmod 755 -R $ANDROID_DIR
sudo chown vagrant:vagrant -R $ANDROID_DIR

