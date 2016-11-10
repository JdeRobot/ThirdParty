ardronelib
==========

CMake installer for **ARDroneLib**.

It will install *ARDroneSDK 2.0.1* dependency for *ardrone_server*

Install
-------
* Install dependencies:

   `sudo apt-get install libsdl1.2-dev`

* Create a build directory and move into it:

  `mkdir ardronelib-build && cd ardronelib-build`
  
* Get **CMakeLists.txt** and related files with:

  ```
  wget https://raw.githubusercontent.com/RoboticsURJC/JdeRobot-ThirdParty/master/ardronelib/CMakeLists.txt
  wget https://raw.githubusercontent.com/RoboticsURJC/JdeRobot-ThirdParty/master/ardronelib/ffmpeg-0.8.pc.in
  wget https://raw.githubusercontent.com/RoboticsURJC/JdeRobot-ThirdParty/master/ardronelib/ardronelib.pc.in
  ```
  
* Build it:

  ```
  cmake .
  make
  sudo make install
  ```

## Additional Notes
* Remove it with: `make uninstall`
* You can also create a debian package with: `make package`
* Check install state with: `ls -ld /usr/local/{include,lib}/jderobot/ardrone`
