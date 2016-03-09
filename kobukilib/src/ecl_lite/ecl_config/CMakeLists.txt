##############################################################################
# Cmake
##############################################################################

cmake_minimum_required(VERSION 2.8.3)
project(ecl_config)

##############################################################################
# Catkin
##############################################################################

find_package(catkin REQUIRED COMPONENTS ecl_build)
file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/include)
catkin_package(
	INCLUDE_DIRS include ${CATKIN_DEVEL_PREFIX}/include
	)

##############################################################################
# ECL Configuration
##############################################################################

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ecl_build_DIR}/modules)
include(ecl_platform_detection)
ecl_detect_platform()
include_directories(${CATKIN_DEVEL_PREFIX}/include)

##############################################################################
# Actual project configuration
##############################################################################

include_directories(${catkin_INCLUDE_DIRS})

add_subdirectory(include)
add_subdirectory(src)


