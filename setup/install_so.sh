#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://samtay.github.io/so/install.sh \
  | bash -s -- --force --to /home/vagrant/bin
