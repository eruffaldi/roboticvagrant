
#Orocos as before hydro
mkdir -p ~/orocos_ws/src
cd ~/orocos_ws/src

#http://wiki.ros.org/orocos_toolchain_ros/groovy
wstool init .
cat orocosgits.txt | wstool merge -
wstool update
cd orocos_toolchain
git submodule foreach git checkout toolchain-2.8

...

cd ~/orocos_ws
chmod +x src/orocos_toolchain/env.sh
src/orocos_toolchain/env.sh catkin_make  --install --cmake-args -DENABLE_CORBA=TRUE -DCORBA_IMPLEMENTATION=OMNIORB
