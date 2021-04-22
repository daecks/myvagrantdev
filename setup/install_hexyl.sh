#!/bin/sh
VERSION=0.4.0

cd /tmp
wget -q "https://github.com/sharkdp/hexyl/releases/download/v${VERSION}/hexyl_${VERSION}_amd64.deb"
sudo dpkg -i hexyl_${VERSION}_amd64.deb
