##############################################################################
# Cmake
##############################################################################

cmake_minimum_required(VERSION 2.8.3)
project(ecl_time_lite)

##############################################################################
# Catkin
##############################################################################

find_package(catkin REQUIRED COMPONENTS ecl_build ecl_config ecl_errors)
file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/include)

##############################################################################
# Platform Configuration
##############################################################################

# This configures ECL_PLATFORM_TIME_LIBRARIES and 
# other ECL_PLATFORM_HAS_XXX flags
ecl_detect_timers()  

##############################################################################
# Exports
##############################################################################

catkin_package(
        INCLUDE_DIRS include ${CATKIN_DEVEL_PREFIX}/include
        LIBRARIES ${PROJECT_NAME}
        DEPENDS ECL_PLATFORM_TIME
	)
include_directories(include ${catkin_INCLUDE_DIRS})

##############################################################################
# CMake File Configuration
##############################################################################

# Make sure we pick up cmake configured files
include_directories(${CATKIN_DEVEL_PREFIX}/include)

##############################################################################
# Actual project configuration
##############################################################################

add_subdirectory(include)
add_subdirectory(src)


