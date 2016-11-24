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
XENOMAIVER=2.6.4
KERNELVER=3.14.17
KERENLFAM=3.x
ARCH=x86
ARCHXENO=amd64
PATCHVER=4
mkdir newkernel
cd newkernel

apt-get install fakeroot kernel-package
apt-get install build-essential crash kexec-tools kernel-wedge git-core libncurses5 libncurses5-dev libelf-dev binutils-dev 
apt-get install devscripts debhelper dh-kpatches autotools-dev autoconf automake libtool libncurses5-dev

wget -O - https://xenomai.org/downloads/xenomai/stable/latest/xenomai-${XENOMAIVER}.tar.bz2| tar -jxf -
cd xenomai-${XENOMAIVER}
DEBEMAIL="emanuele.ruffaldi@sssup.it" DEBFULLNAME="Emanuele Ruffaldi" debchange -v ${XENOMAIVER} Release ${XENOMAIVER}
debuild -uc -us
dpkg -i ../*.deb
cd ..
wget https://www.kernel.org/pub/linux/kernel/v${KERENLFAM}/linux-${KERNELVER}.tar.gz
tar -zxf linux-${KERNELVER}.tar.gz
cd linux-${KERNELVER}

../${XENOMAIVER}/scripts/prepare-kernel.sh --arch=${ARCHXENO} --adeos=../xenomai-${XENOMAIVER}/ksrc/arch/${ARCH}/patches/ipipe-core-${KERNELVER}-${ARCH}-${PATCHVER}.patch --linux=.

#sudo cp -vi /boot/config-`uname -r` .config
cat /boot/config-`uname -r` | python patchconfig.py configchanges.txt
#
#Take the original configuration from Ubuntu
CONCURRENCY_LEVEL=7 fakeroot make-kpkg --bzimage --initrd --append-to-version=-xenomai-${XENOMAIVER}  --config defconfig kernel-image kernel-headers modules
cd ..
dpkg -i linux-image-*.deb
dpkg -i linux-headers-*.deb

update-initramfs -c -k "${KERNELVER}-xenomai-${XENOMAIVER}-ipipe"
update-grub

