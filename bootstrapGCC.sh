#!/usr/bin/env bash

# Setup of GCC 4.8.*
apt-get install python-software-properties
add-apt-repository ppa:ubuntu-toolchain-r/test


apt-get update

#GCC
apt-get install gcc-4.8
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
