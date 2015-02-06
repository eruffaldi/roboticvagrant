#!/usr/bin/env bash

# Setup of GCC 4.8.*
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install python-software-properties
add-apt-repository ppa:ubuntu-toolchain-r/test


apt-get update

#GCC
apt-get -q -y install gcc-4.8
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
