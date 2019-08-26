#!/bin/sh

VERSION=0.10.0
cd /tmp
curl -sLO https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/ripgrep_${VERSION}_amd64.deb 
sudo dpkg -i ripgrep_${VERSION}_amd64.deb
