#!/usr/bin/env bash

#reboot
#https://xenomai.org//installing-xenomai-2-x/
cd newkernel
mkdir buildxenomai
cd buildxenomai
rm ../xenomai-2.6.4/config.status 
../xenomai-2.6.4/configure --enable-shared --enable-x86-tsc --enable-smp  --enable-posix-auto-mlockall --enable-dlopen-skins --enable-x86-sep
# --enable-posix-auto-mlockall --enable-dlopen-skins --enable-x86-sep
make -j 7
make install