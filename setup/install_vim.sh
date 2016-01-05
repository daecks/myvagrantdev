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

# Force symlink of .vimrc
if ! [ -L /home/vagrant/.vimrc ]; then
    # Remove non-symlinked file
    rm /home/vagrant/.vimrc
    ln -s /vagrant/setup/.vimrc /home/vagrant/.vimrc
fi

# Get Vundle for package management
if [ -d "$VUNDLE_DIR" ]; then
    cd $VUNDLE_DIR && git pull
else
    git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
fi
find $VUNDLE_DIR -type f -print0 | xargs -0 dos2unix -q
sudo chown -R vagrant:vagrant $VUNDLE_DIR

# Install YCM and enable autocompletion with clang complete
if [ -d "$YCM_DIR" ]; then
    cd $YCM_DIR && git pull
else
    git clone https://github.com/Valloric/YouCompleteMe.git $YCM_DIR
fi
cd $YCM_DIR && find . -type f -print0 | xargs -0 dos2unix -q && git submodule update --init --recursive && python install.py --clang-completer
sudo chown -R vagrant:vagrant $YCM_DIR

# Run Vundle to install other plugins
gvim +PluginInstall +qall
echo "Finished installing Vim"
