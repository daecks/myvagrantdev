#!/bin/bash

export CARGO_HOME=/home/vagrant/.cargo
export RUSTUP_HOME=${CARGO_HOME}/bin

# Run curl https://sh.rustup.rs -sSf | sh -s -- --help
# to see what options we're dealing with, here.
curl https://sh.rustup.rs -sSf | sh -s -- --default-host x86_64-unknown-linux-gnu --default-toolchain stable --profile default -y -q

