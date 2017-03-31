# QFlightInstruments for C++ and Python3.5

This is collection of Qt4 and Qt5 widgets of flight instruments, inluding Attitude Indicator, Airspeed Indicator, Vertical Speed Indicator, Turn Indicator, Horizontal Situation Indicator, Primary Flight Display and Navigation Display.

This library replaces Qwt in order to make JdeRobot full compatible with Qt5 and PyQt5 using the same widgets.
The original library is written in C++ only, but one of our developers (Aitor) translated it to python to make it compatible with JdeRobot TeachingRobotics examples.

# Requisites

You may need qt4 or qt5 qmake version in order to compile the library.

    sudo apt-get install qt5-qmake qt5-default
    


# Build it!

Using qmake build as usual

    mkdir build && cd build
    qmake ..
    make
    make install
    
The building proccess will generate a debian package, so you can deploy wherever you want. The .deb package will install both C++ and Python libraries in

    /usr/lib for the generated .so in C++
    /usr/include for headers in C++
    /usr/lib/python3/dist-packages/qfi for Python 3 modules
    /usr/lib/python2.7/dist-packages/qfi for Python 2.7 modules
    
Enjoy it!




# Make Package

Install necesaries packages

    sudo apt-get install build-essential devscripts ubuntu-dev-tools debhelper dh-make diffutils patch gnupg fakeroot lintian pbuilder cdbs
    
make package
    debuild -uc -us


Author: Marek Cel <marekcel@marekcel.pl>
Web: http://marekcel.pl/index.php?pg=qfi

Modified by: Aitor Martinez <aitor.martinez.fernandez@gmail.com>
