

# Usage

Vagrant
Ubuntu LTS
Vagrant reload plugin: https://github.com/aidanns/vagrant-reload
Vagrant vb syncronization (optional) https://github.com/dotless-de/vagrant-vbguest

The base Vagrant box should be a Ubuntu 12.04/14.04/16.04 x86_64 such as Official Ubuntu 12.04/14.04/16.04 daily Cloud Image amd64 from http://www.vagrantbox.es/.


# Enable 3D Acceleration

Add this: vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
