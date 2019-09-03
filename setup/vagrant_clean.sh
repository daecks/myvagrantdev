#!/bin/bash

# This script zeroes out any space not needed for packaging a new Ubuntu Vagrant base box.
# Run the following command in a root shell:
#
# bash <(curl -s https://gist.github.com/justindowning/5670884/raw/vagrant-clean.sh)

function print_green {
  echo -e "\e[32m${1}\e[0m"
}

print_green 'Clean Apt'
apt-get -qq autoremove
aptitude clean
aptitude autoclean

print_green 'Cleanup bash history'
unset HISTFILE
[ -f /root/.bash_history ] && rm /root/.bash_history
[ -f /home/vagrant/.bash_history ] && rm /home/vagrant/.bash_history
 
print_green 'Cleanup log files'
find /var/log -type f | while read f; do echo -ne '' > $f; done
 
print_green 'Removing private data'
rm /home/vagrant/.gitconfig
rm /home/vagrant/.ssh/id_rsa
rm /home/vagrant/.ssh/id_rsa.pub
rm /home/vagrant/.ssh/known_hosts
rm /home/vagrant/.ssh/authorized_keys
wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys

print_green 'Whiteout root'
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace
 
print_green 'Whiteout /boot'
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace

#print_green 'Whiteout swap'
#swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
#swapoff $swappart
#dd if=/dev/zero of=$swappart
#mkswap -f $swappart
#swapon $swappart

print_green 'Zero out disk'
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

print_green 'Vagrant cleanup complete!'


