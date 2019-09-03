#!/bin/bash

sudo apt-get -qq install bat

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo "Y Y" | ~/.fzf/install
