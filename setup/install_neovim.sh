#!/bin/bash
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get -qq update
sudo apt-get install neovim -y --force-yes
sudo apt-get install python-dev python-pip python3-dev python3-pip -y --force-yes
