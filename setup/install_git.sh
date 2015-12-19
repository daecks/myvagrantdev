#!/bin/bash
#repo_already_exists=`find /etc/apt/ -name *.list | xargs cat | grep git-core`
#if [ -n $repo_already_exists ]; then
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get -qq update
#fi
sudo apt-get install -y --force-yes git
sudo apt-get install -y --force-yes git-gui
sudo apt-get install -y --force-yes gitk
sudo apt-get install -y --force-yes git-man
git --version


#"^[^#;]"
