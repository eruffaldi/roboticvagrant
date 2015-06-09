#/bin/sh
sudo sh -c 'echo "deb http://www.icub.org/ubuntu trusty contrib/science" > /etc/apt/sources.list.d/icub.list'

. /etc/lsb-release
if [[ "$DISTRIB_RELEASE" == '12.04' ]]; then
sudo add-apt-repository ppa:kalakris/cmake
#sudo add-apt-repository ppa:george-edison55/cmake-3.x 
fi
sudo apt-get update
sudo apt-get install --only-upgrade cmake
sudo apt-get install yarp

if [[ "$DISTRIB_RELEASE" == '12.04' ]]; then
sudo ln -s /usr/lib/libACE-6.0.1.so /usr/lib/libACE-6.0.3.so
fi