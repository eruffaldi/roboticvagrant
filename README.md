
# Original Idea
This work originally started as a way for preparing VM for robotic application, actually before switching to the Docker approach. For this reason we initially used Vagrant

The original blog post on Vagrant:
* http://teslacore.blogspot.it/2015/01/packaging-your-robotic-vm-with-vagrant.html
* http://teslacore.blogspot.it/2015/06/robotic-vagrant-for-yarp.html

And then the more recent docker approach:
* http://teslacore.blogspot.it/2016/07/docker-for-our-ros-robotic-overlords.html

# Xenomai
As part of these setup script I have prepared Xenomai configuration tools for v2 of Xenomai and then tried to update them for v3. v3 scripts are note tested. There are three script P1..P3.sh that have to be lanunched followed by a reboot.

The nice thing of this approach is that it automatically configures Linux parameters via a python script.

Check the environment variables for specifying the match between Xenomai version and your kernel version


# Requirements for Vagrant testing
------------
Vagrant
Ubuntu 12.04 x86_64
Vagrant reload plugin: https://github.com/aidanns/vagrant-reload
Vagrant vb syncronization (optional) https://github.com/dotless-de/vagrant-vbguest

The base Vagrant box should be a Ubuntu 12.04/14.04 x86_64 such as Official Ubuntu 12.04/14.04 daily Cloud Image amd64 from http://www.vagrantbox.es/.
