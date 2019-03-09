#!/bin/bash
echo "Installing Android Studio"
sudo add-apt-repository -y ppa:maarten-fonville/android-studio
sudo apt-get -y -qq update
sudo apt-get -q -y --force-yes install android-studio
echo "Finished installing Android Studio"
echo -e "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Terminal=false\n\
Name=Android Studio\n\
Exec=/opt/android-studio/bin/studio.sh\n\
Comment=Integrated Android developer tools for development and debugging.\n\
Icon=androidstudio\n\
Categories=GNOME;GTK;Development;IDE;" > /home/vagrant/Desktop/android-studio.desktop

