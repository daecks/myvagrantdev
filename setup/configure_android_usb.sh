#!/bin/bash
# More USB setup for adb and fastboot to recognize device
if [ -f /etc/udev/rules.d/51-android.rules ]; then sudo rm -rf /etc/udev/rules.d/51-android.rules; fi

sudo sh -c "echo 'SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"05c6\", MODE=\"0666\"' >> /etc/udev/rules.d/51-android.rules"
sudo sh -c "echo 'SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"18d1\", MODE=\"0666\"' >> /etc/udev/rules.d/51-android.rules"
sudo chmod 644   /etc/udev/rules.d/51-android.rules
sudo chown root. /etc/udev/rules.d/51-android.rules
sudo udevadm control --reload-rules
sudo killall -q adb

