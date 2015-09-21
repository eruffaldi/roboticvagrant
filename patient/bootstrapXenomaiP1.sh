#!/usr/bin/env bash


#Kernel Options
#In Power management and ACPI options
#	ACPI (Advanced Configura- tion and Power Interface) Support turn of Processor,
#		CONFIG_ACPI_PROCESSOR is not set
#	CPU Frequency scaling turn off CPU Frequency scaling,
#		CONFIG_CPU_FREQ is not set
#	ACPI options turn off CPU idle PM support,
#		CONFIG_CPU_IDLE
#		CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
#Kernel hacking turn off KGDB: kernel debugger,
#		CONFIG_KGDB is not set
#Turn off Virtualization,
# 		CONFIG_VIRTUALIZATION is not set

#See http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on-ubuntu-12-04/

mkdir newkernel
cd newkernel

apt-get install fakeroot kernel-package
apt-get install build-essential crash kexec-tools kernel-wedge git-core libncurses5 libncurses5-dev libelf-dev binutils-dev 
apt-get install devscripts debhelper dh-kpatches autotools-dev autoconf automake libtool libncurses5-dev

wget -O - http://download.gna.org/xenomai/stable/xenomai-2.6.4.tar.bz2| tar -jxf -
cd xenomai-2.6.4
DEBEMAIL="emanuele.ruffaldi@sssup.it" DEBFULLNAME="Emanuele Ruffaldi" debchange -v 2.6.4 Release 2.6.4
debuild -uc -us
dpkg -i ../*.deb
cd ..
wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.17.tar.gz
tar -zxf linux-3.14.17.tar.gz
cd linux-3.14.17

../xenomai-2.6.4/scripts/prepare-kernel.sh --arch=amd64 --adeos=../xenomai-2.6.4/ksrc/arch/x86/patches/ipipe-core-3.14.17-x86-4.patch --linux=.

#sudo cp -vi /boot/config-`uname -r` .config
cat /boot/config-`uname -r` | python /vagrant/kernelconfigpatcher.py /vagrant/configchanges.txt

#Take the original configuration from Ubuntu
CONCURRENCY_LEVEL=7 fakeroot make-kpkg --bzimage --initrd --append-to-version=-xenomai-2.6.4  --config defconfig kernel-image kernel-headers modules
cd ..
dpkg -i linux-image-*.deb
dpkg -i linux-headers-*.deb

update-initramfs -c -k "3.14.17-xenomai-2.6.4-ipipe"
update-grub

