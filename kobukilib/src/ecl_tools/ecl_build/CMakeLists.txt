##############################################################################
# Cmake
##############################################################################

cmake_minimum_required(VERSION 2.8.3)
project(ecl_build)

##############################################################################
# Catkin
##############################################################################

find_package(catkin REQUIRED)

set(${PROJECT_NAME}_MODULES "")
list(APPEND ${PROJECT_NAME}_MODULES ecl_platform_detection.cmake)
list(APPEND ${PROJECT_NAME}_MODULES ecl_package.cmake)
list(APPEND ${PROJECT_NAME}_MODULES ecl_find_sse.cmake)
list(APPEND ${PROJECT_NAME}_MODULES ecl_build_utilities.cmake)
list(APPEND ${PROJECT_NAME}_MODULES ecl_cx11.cmake)
list(APPEND ${PROJECT_NAME}_MODULES cotire.cmake)

catkin_package(
    CFG_EXTRAS ${${PROJECT_NAME}_MODULES}
)


##############################################################################
# Work
##############################################################################

install(DIRECTORY cmake
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)


