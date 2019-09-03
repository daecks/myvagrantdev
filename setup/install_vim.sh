#!/bin/bash
echo "Installing Vim"

VIM_DIR=/home/vagrant/.vim
VUNDLE_DIR=/home/vagrant/.vim/bundle/Vundle.vim
YCM_DIR=/home/vagrant/.vim/bundle/YouCompleteMe

if [ -d "$VIM_DIR" ]; then
    sudo chown -R vagrant:vagrant $VIM_DIR
fi

sudo add-apt-repository -y ppa:jonathonf/vim

# Ensure dependencies are met
sudo apt-get -qq update
sudo apt-get install -qq libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev \
    build-essential cmake ncurses-dev python2.7-dev dos2unix checkinstall

sudo apt-get install -qq vim-gtk vim

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
yes "" | vim +PluginInstall +qall

# Update YCM installation
cd /home/vagrant/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --all

echo "Finished installing Vim"
