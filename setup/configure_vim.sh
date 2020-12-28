#!/bin/bash

echo "Configuring Vim"

VIM_DIR=/home/vagrant/.vim
VUNDLE_DIR=/home/vagrant/.vim/bundle/Vundle.vim

if [ -d "$VIM_DIR" ]; then
    sudo chown -R vagrant:vagrant $VIM_DIR
fi

# Force symlink of .vimrc
if ! [ -L /home/vagrant/.vimrc ]; then
    # Remove non-symlinked file
    rm -f /home/vagrant/.vimrc
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

# Run Vundle to install other plugins
# NO! Doesn't work through SSH command line
#yes "" | vim +PluginInstall +qall

echo "Finished configuring Vim"
