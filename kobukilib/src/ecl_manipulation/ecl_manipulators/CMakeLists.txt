##############################################################################
# Cmake
##############################################################################

cmake_minimum_required(VERSION 2.8.3)
project(ecl_manipulators)

##############################################################################
# Catkin
##############################################################################

find_package(catkin
    REQUIRED
    COMPONENTS
        ecl_build 
        ecl_exceptions
        ecl_geometry
        ecl_formatters
)

##############################################################################
# Exports
##############################################################################

catkin_package(
    INCLUDE_DIRS include
    LIBRARIES ${PROJECT_NAME}
    CATKIN_DEPENDS
        ecl_build
        ecl_exceptions
        ecl_geometry
        ecl_formatters
        )

##############################################################################
# Project Configuration
##############################################################################

ecl_enable_cxx11_compiler()
include_directories(include ${catkin_INCLUDE_DIRS})

##############################################################################
# Sources
##############################################################################

add_subdirectory(include)
add_subdirectory(src)

##############################################################################
# Installs
##############################################################################

install(DIRECTORY scripts 
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
        PATTERN "CMakeLists.txt" EXCLUDE
       )



