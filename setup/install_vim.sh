#!/bin/bash
echo "Installing Vim"
VIM_DIR=/home/vagrant/.vim
VUNDLE_DIR=/home/vagrant/.vim/bundle/Vundle.vim
YCM_DIR=/home/vagrant/.vim/bundle/YouCompleteMe

if [ -d "$VIM_DIR" ]; then
    sudo chown -R vagrant:vagrant $VIM_DIR
fi

# Ensure dependencies are met
sudo apt-get -qq update
sudo apt-get install -y build-essential cmake ncurses-dev python2.7-dev dos2unix

# Get gVim
sudo apt-get install -y vim-gtk

# Copy across .vimrc
sudo cp /vagrant/setup/.vimrc /home/vagrant/.vimrc
sudo chown vagrant:vagrant /home/vagrant/.vimrc

# Get Vundle for package management
if [ -d "$VUNDLE_DIR" ]; then
    sudo rm -rf $VUNDLE_DIR
fi
git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
find $VUNDLE_DIR -type f -print0 | xargs -0 dos2unix -q

# Install YCM and enable autocompletion with clang complete
if [ -d "$YCM_DIR" ]; then
    sudo rm -rf $YCM_DIR
fi
git clone https://github.com/Valloric/YouCompleteMe.git $YCM_DIR
cd /home/vagrant/.vim/bundle/YouCompleteMe
find . -type f -print0 | xargs -0 dos2unix -q
git submodule update --init --recursive
python install.py --clang-completer

# Run Vundle to install other plugins
vim +PluginInstall +qall
echo "Finished installing Vim"
