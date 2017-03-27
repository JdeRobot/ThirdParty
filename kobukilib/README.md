# KobukiLib

Set of libraries of the Turtlebot robot from Yujin. Needed to compile JdeRobot's kobuki_driver

## Installation

In order to compile this libraries from source, you should:

  1. Add ROS sources and key
  
    ```sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'```
    
    ```sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116```
    
  2. Add JdeRobot sources and key
  
      ```sudo sh -c 'cat<<EOF>/etc/apt/sources.list.d/jderobot.list
# for ubuntu 16.04 LTS (64 bit)

deb http://jderobot.org/apt xenial main
deb-src http://jderobot.org/apt xenial main
EOF'```
    
    ```sudo apt-key adv --keyserver keyserver.ubuntu.com --recv B0E7F58E82C8091DF945A0453DA08892EE69A25C```
  
  3. Update the package index:

    ```sudo apt-get update```

  4. Install dependencies:
  
    ```sudo apt-get install python-wstool python-catkin-pkg python-empy python-nose python-setuptools build-essential libeigen3-dev sophus```
    
  5. Download this repository
  
    ```git clone https://github.com/RoboticsURJC/JdeRobot-ThirdParty.git ```
    
    ```cd kobukilib/build```
    
  6. Compile and install
  
    ```cmake .. && make && sudo make install```


## Usage

This code is needed to compile kobuki_driver component from JdeRobot official repository. Once installed you should be able to compile kobuki_driver.i

## Additional Notes

* Remove it with: `make uninstall`
* You can also create a debian package with: `make package`
