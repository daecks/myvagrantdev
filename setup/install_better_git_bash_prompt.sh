#!/bin/bash
APP_DIR=/home/vagrant/.bash-git-prompt
if [ -d $APP_DIR ]; then
    cd $APP_DIR && git pull && cd -
else
    cd /home//vagrant
    git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt
fi

grep -q -F 'source /home/vagrant/.bash-git-prompt/gitprompt.sh' /home/vagrant/.bashrc || echo 'source /home/vagrant/.bash-git-prompt/gitprompt.sh' >> /home/vagrant/.bashrc
