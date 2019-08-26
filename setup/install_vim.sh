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
sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev \
    build-essential cmake ncurses-dev python2.7-dev dos2unix checkinstall

sudo apt-get install -y vim-gtk vim

## INSTALL FROM SOURCE

# Remove existing version of Vim
#sudo apt-get remove -y vim vim-runtime gvim
## Install latest Vim
#cd /tmp && git clone https://github.com/vim/vim.git
#cd vim
#./configure --with-features=huge \
#   --enable-multibyte \
#   --enable-rubyinterp \
#   --enable-pythoninterp=yes \
#   --with-python-config-dir=/usr/lib/python2.7/config \
#   --enable-python3interp \
#   --with-python3-config-dir=/usr/lib/python3.5/config \
#   --enable-perlinterp \
#   --enable-luainterp \
#   --enable-gui=gtk2 \
#   --enable-cscope \
#   --prefix=/usr
#make VIMRUNTIMEDIR=/usr/share/vim/
#sudo make install
#sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
#sudo update-alternatives --set editor /usr/bin/vim
#sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
#sudo update-alternatives --set vi /usr/bin/vim

# END INSTALL FROM SOURCE

# Force symlink of .vimrc
if ! [ -L /home/vagrant/.vimrc ]; then
    # Remove non-symlinked file
    rm /home/vagrant/.vimrc
    ln -s /vagrant/apps/vim/.vimrc /home/vagrant/.vimrc
fi

# Get Vundle for package management
if [ -d "$VUNDLE_DIR" ]; then
    cd $VUNDLE_DIR && git pull
else
    git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
fi
find $VUNDLE_DIR -type f -print0 | xargs -0 dos2unix -q
sudo chown -R vagrant:vagrant $VUNDLE_DIR

## Install YCM and enable autocompletion with clang complete
#if [ -d "$YCM_DIR" ]; then
#    echo "YCM directory exists... updating"
#    cd $YCM_DIR && git pull
#    # Try to really clorox everything
#    git submodule update --recursive
#    git submodule update --init --recursive
#    git submodule foreach --recursive git reset --hard
#    git submodule foreach --recursive git checkout -- .
#    git submodule foreach --recursive git clean -fxd
#    git submodule foreach 'git fetch origin; git checkout $(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'
#else
#    echo "Cloning down YCM for first time"
#    git clone https://github.com/Valloric/YouCompleteMe.git $YCM_DIR
#fi
#
#cd $YCM_DIR
#sudo chown -R vagrant:vagrant $YCM_DIR
#./install.sh --clang-completer

# Run Vundle to install other plugins
#gvim +PluginInstall +qall
echo "Finished installing Vim"
