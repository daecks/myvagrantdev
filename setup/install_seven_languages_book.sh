#!/bin/bash
echo "Install seven languages book dependencies"

sudo apt-get install -qq ruby
sudo apt-get install -qq swi-prolog-nox
sudo apt-get install -qq scala
sudo apt-get install -qq erlang
sudo apt-get install -qq haskell-platform

cd /tmp
curl -O https://download.clojure.org/install/linux-install-1.10.1.469.sh
chmod +x linux-install-1.10.1.469.sh
sudo ./linux-install-1.10.1.469.sh

echo "Finished installing (most) seven languages book dependencies"
