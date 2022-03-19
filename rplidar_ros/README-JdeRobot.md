# RPLIDAR-ROS
This directory is taken from the repository https://github.com/allenh1/rplidar_ros in the ROS2 branch.  

To use it you need to have installed ROS2 foxy or some compatible distribution of ROS2  

# Usage
~~~bash
ros2 launch rplidar_ros rplidar.launch.py
~~~
If you need to change the usb port (/dev/ttyUSB0), access the following file:  
**./launch/rplidar.launch.py**  

~~~py
...
        Node(
            node_name='rplidar_composition',
            package='rplidar_ros',
            node_executable='rplidar_composition',
            output='screen',
            parameters=[{
                'serial_port': '/dev/ttyUSB0', # Change this line
                'serial_baudrate': 115200,
...
~~~
