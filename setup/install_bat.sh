#!/bin/bash
set -e

VERSION=0.10.0
BAT_URL=https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_amd64.deb
echo "Installing Bat verion ${VERSION}"
cd /tmp
wget -N -q $BAT_URL
sudo dpkg -i bat_${VERSION}_amd64.deb
echo "Finished installing Bat"
