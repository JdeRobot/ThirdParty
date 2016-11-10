# KobukiLib

Set of libraries of the Turtlebot robot from Yujin. Needed to compile JdeRobot's kobuki_driver

## Installation

In order to compile this libraries from source, you should:

  1. Add ROS sources and key
  
    ```sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'```
    
    ```sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116```
  
  2. Update the package index:

    ```sudo apt-get update```

  3. Install dependencies:
  
    ```sudo apt-get install python3-wstool python3-catkin-pkg python3-empy python3-nose python3-setuptools build-essential libeigen3-dev sophus```
    
  4. Download this repository
  
    ```git clone https://github.com/RoboticsURJC/JdeRobot-ThirdParty.git ```
    
    ```cd kobukilib/build```
    
  5. Compile and install
  
    ```cmake .. && make && sudo make install```


## Usage

This code is needed to compile kobuki_driver component from JdeRobot official repository. Once installed you should be able to compile kobuki_driver.i

## Additional Notes

* Remove it with: `make uninstall`
* You can also create a debian package with: `make package`
