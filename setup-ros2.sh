#!/bin/bash




#####################################################################
# ROS2 Foxy Fitzroy  
# on Ubuntu 20.04 (Focal)
# https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html
#####################################################################

# ros2 version
ros2_ver=foxy

# set locale
sudo apt update && sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# setup sources
sudo apt install software-properties-common -y
sudo add-apt-repository universe -y
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# install ros2 packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install ros-${ros2_ver}-desktop python3-argcomplete -y
sudo apt install ros-dev-tools -y

# environment setup
source /opt/ros/${ros2_ver}/setup.bash
# below is for later use
echo "source /opt/ros/${ros2_ver}/setup.bash" >> ~/.bashrc

# rosdep
sudo rosdep init
sudo rosdep update 




#####################################################################
# Micro-ROS
# on Ubuntu 20.04 (Focal)
# https://micro.ros.org/docs/tutorials/core/first_application_linux/
#####################################################################

# workspace directory
mcros_dir=$HOME/micro-ros

# create a workspace and download the Micro-ROS tools
mkdir ${mcros_dir}
cd ${mcros_dir}
git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup

# update dependencies using rosdep
sudo apt update && rosdep update -y
rosdep install --from-paths src --ignore-src -y

# install pip
sudo apt-get install python3-pip -y

# build micro-ROS tools and source them
colcon build
source install/local_setup.bash
# below is for later use
echo "source ${mcros_dir}/install/local_setup.bash" >> ~/.bashrc






#####################################################################
# Arduino-client 
# on Ubuntu 20.04 (Focal)
# https://arduino.github.io/arduino-cli/0.24/installation/
#####################################################################

# workspace for ino
ino_dir=$HOME/ino-cli

# create a workspace and download ino
mkdir ${ino_dir}
cd ${ino_dir}
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

# add path 
echo "export PATH='${ino_dir}:$PATH'" >> ~/.bashrc





