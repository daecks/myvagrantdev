
VIM_DIR=/home/vagrant/.vim
VUNDLE_DIR=/home/vagrant/.vim/bundle/Vundle.vim
YCM_DIR=/home/vagrant/.vim/bundle/YouCompleteMe

# Ensure dependencies are met
sudo apt-get -qq update
sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev git \
    build-essential cmake ncurses-dev python2.7-dev dos2unix checkinstall

# Remove existing version of Vim
sudo apt-get remove -y vim vim-runtime gvim

# Install latest Vim
sudo add-apt-repository -y ppa:laurent-boulard/vim
sudo apt-get -y -qq update
sudo apt-get -y install vim-gtk

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

if [ -d "$VIM_DIR" ]; then
    sudo chown -R vagrant:vagrant $VIM_DIR
fi

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
