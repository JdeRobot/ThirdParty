##############################################################################
# Cmake
##############################################################################

cmake_minimum_required(VERSION 2.8.3)
project(ecl_io)

##############################################################################
# Catkin
##############################################################################

set(sockets_INCLUDE_DIRS "") # Just assume they're in the system dirs for now
if(MINGW)
  set(sockets_LIBRARIES rpcrt4 shell32 ws2_32 advapi32 kernel32 msvcrt)
elseif(WIN32)
  find_library(sockets_LIBRARIES ws2_32)
else()
    set(sockets_LIBRARIES "")
endif()

##############################################################################
# Catkin
##############################################################################

find_package(catkin REQUIRED COMPONENTS ecl_config ecl_errors)
catkin_package(
        INCLUDE_DIRS include
        LIBRARIES ${PROJECT_NAME}
        DEPENDS sockets
        )
include_directories(include ${catkin_INCLUDE_DIRS})

##############################################################################
# Actual project configuration
##############################################################################

add_subdirectory(include)
add_subdirectory(src)

