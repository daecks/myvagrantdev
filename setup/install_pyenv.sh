#!/bin/bash

sudo apt-get install -y -qq make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Note: if you're not on Vagrant, ensure the following is added to your
# .bashrc/.profile
#if [ -e $HOME/.pyenv/bin ]; then
#    PATH=$HOME/.pyenv/bin;$PATH
#    eval "$(pyenv init -)"
#    eval "$(pyenv virtualenv-init -)"
#    pyenv install -s 3.5.7
#    pyenv install -s 2.7.16
#fi

