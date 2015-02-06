#!/usr/bin/env bash

apt-get install libboost-all-dev tcl tk lua5.2 libopencv-dev libpcl-1.7-all-dev screen htop mc vim ruby

#Orocos as before hydro
cd
export ROS_WORKSPACE=~/ros_workspace
mkdir $ROS_WORKSPACE
cd $ROS_WORKSPACE
rosws init . /opt/ros/hydro
roscd
rosws set orocos/orocos_toolchain https://github.com/orocos-toolchain/orocos_toolchain.git -v toolchain-2.8 --git 
rosws set orocos/rtt_ros_integration http://git.mech.kuleuven.be/robotics/rtt_ros_integration.git -v hydro --git 
rosws set orocos/rtt_ros_comm http://git.mech.kuleuven.be/robotics/rtt_ros_comm.git -v hydro --git 
rosws set orocos/rtt_common_msgs http://git.mech.kuleuven.be/robotics/rtt_common_msgs.git -v hydro  --git 
rosws set orocos/rtt_geometry http://git.mech.kuleuven.be/robotics/rtt_geometry.git -v hydro --git
rosws update
rosws regenerate
export ROS_PACKAGE_PATH="~/ros_workspace":$ROS_PACKAGE_PATH
source setup.sh
roscd orocos_toolchain
source env.sh
export OROCOS_TARGET=xenomai
export XENOMAI_INCLUDE_DIR="/usr/xenomai/include"
export XENOMAI_NATIVE_LIBRARY="/usr/xenomai/lib"
export XENOMAI_ROOT_DIR="/usr/xenomai"
rosdep update
rosdep install orogen

rosmake orocos_toolchain rtt_ros_integration rtt_ros_comm rtt_common_msgs rtt_geometry

#User integration
echo "export ROS_WORKSPACE=$ROS_WORKSPACE" >> ~/.bashrc
echo "export ROS_PACKAGE_PATH="/home/remedi/ros_workspace"\
:$ROS_PACKAGE_PATH" >> ~/.bashrc
echo "export OROCOS_TARGET=xenomai" >> ~/.bashrc
echo "export XENOMAI_INCLUDE_DIR=/usr/xenomai/include" >> ~/.bashrc
echo "export XENOMAI_NATIVE_LIBRARY=/usr/xenomai/lib" >> ~/.bashrc
echo "export XENOMAI_ROOT_DIR=/usr/xenomai" >> ~/.bashrc
echo "source $ROS_WORKSPACE/orocos/orocos_toolchain/env.sh" >> ~/.bashrc

source ~/.bashrc