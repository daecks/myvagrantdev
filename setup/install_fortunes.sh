#!/bin/bash
sudo apt-get install -y fortune cowsay
sudo cp /vagrant/setup/fortune_quotes /usr/games/fortunes
sudo strfile /usr/games/fortunes
