#!/usr/bin/env bash

#reboot
#https://xenomai.org//installing-xenomai-2-x/
cd newkernel
mkdir buildxenomai
cd buildxenomai
rm ../xenomai-${XENOMAIVR}/config.status 
../xenomai-${XENOMAIVR}/configure --enable-shared --enable-smp --enable-x86-sep
#Was --enable-x86-tsc --enable-smp  --enable-posix-auto-mlockall --enable-dlopen-skins --enable-x86-sep
# --enable-posix-auto-mlockall --enable-dlopen-skins --enable-x86-sep
make -j8
make install