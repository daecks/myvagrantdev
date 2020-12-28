#!/bin/bash

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
sed -i 's/$HOME/\/home\/vagrant/g' install.sh
./install.sh
cd ..
rm -rf fonts

go get -u github.com/justjanne/powerline-go

# Update git colors to match powerline-shell color scheme
git config --global color.status.untracked 009 
git config --global color.status.changed 214 
git config --global color.status.unmerged 203 
