##############################################################################
# Cmake
##############################################################################

cmake_minimum_required(VERSION 2.8.3)
project(ecl_build)

##############################################################################
# Catkin
##############################################################################

find_package(catkin)

catkin_package(
# Play around with this later.
#    CFG_EXTRAS modules/platform_detection.cmake, 
#               modules/ecl_package.cmake, 
#               modules/ecl_build_utilities.cmake, 
#               templates/uninstall.cmake
)


##############################################################################
# Work
##############################################################################

add_subdirectory(cmake)


