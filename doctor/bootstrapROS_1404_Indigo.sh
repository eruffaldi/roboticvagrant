#!/usr/bin/env bash
# ROS
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
apt-get update
apt-get -q -y --force-yes  install ros-indigo-desktop-full
#apt-get install ros-hydro-pr2
apt-cache search ros-indigo
rosdep init
rosdep update
apt-get -q -y --force-yes install python-rosinstall

#User integration
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc