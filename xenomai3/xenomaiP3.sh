#!/usr/bin/env bash
cd /etc/ld.so.conf.d/
touch xenomai.conf
echo /usr/xenomai/lib >> xenomai.conf
ldconfig

addgroup xenomai
addgroup root xenomai
usermod -a -G xenomai remedi
