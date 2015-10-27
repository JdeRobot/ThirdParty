cmake_minimum_required(VERSION 2.8)

project(ardronelib)


## Build ARDrone SDK here
set (ARDRONE_SDK_FLAVOR "autonomy-gps")
# Available options:
# official-patched - stripped vanilla SDK 2.0.1 with makefile patches to allow build
# autonomy-lastest - possible fixes and features (like multiple robots with same driver)
# autonomy-gps - experimental GPS support

if (${ARDRONE_SDK_FLAVOR} STREQUAL "official-patched")
    set(GIT_TAG bdacd1cbd3fbc54263d29e6e2067265e5941d10e)
elseif (${ARDRONE_SDK_FLAVOR} STREQUAL "autonomy-lastest")
    set(GIT_TAG master)
elseif (${ARDRONE_SDK_FLAVOR} STREQUAL "autonomy-gps")
    set(GIT_TAG gps)
endif()

message("ardronelib version: ${ARDRONE_SDK_FLAVOR}")
set(ARDRONE_SDK_NAME "ardronelib" )
set(ARDRONE_SDK ${CMAKE_BINARY_DIR}/src/${ARDRONE_SDK_NAME}/ARDroneLib)
set(ARDRONE_SDK_LIB_PATH ${CMAKE_BINARY_DIR}/lib/ardrone)

include(ExternalProject)
ExternalProject_Add(ardronelib
        GIT_REPOSITORY git://github.com/AutonomyLab/ardronelib.git
        GIT_TAG ${GIT_TAG}
        PREFIX ${CMAKE_BINARY_DIR}
        CONFIGURE_COMMAND echo "No configure"
        BUILD_COMMAND make NO_EXAMPLES=yes QUIET_BUILD=yes
        INSTALL_COMMAND make install INSTALL_PREFIX=${ARDRONE_SDK_LIB_PATH}
        BUILD_IN_SOURCE 1
)


## Install it
install(DIRECTORY ${CMAKE_BINARY_DIR}/lib/ardrone/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/jderobot/ardrone
)
ExternalProject_Get_Property(ardronelib SOURCE_DIR)
install(DIRECTORY ${SOURCE_DIR}/ARDroneLib/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/include/jderobot/ardrone
	FILES_MATCHING
		PATTERN "*.h"
		PATTERN README
		PATTERN LICENSE
		PATTERN "Build" EXCLUDE
		REGEX "FFMPEG/ffmpeg" EXCLUDE
)
install(FILES
	"${SOURCE_DIR}/LICENSE"
	"${SOURCE_DIR}/README.md"
	DESTINATION "${CMAKE_INSTALL_PREFIX}/include/jderobot/ardrone"
)
install(FILES
	"${ARDRONE_SDK}/FFMPEG/ffmpeg/VERSION"
	"${ARDRONE_SDK}/FFMPEG/ffmpeg/LICENSE"
	"${ARDRONE_SDK}/FFMPEG/ffmpeg/README"
#	"${ARDRONE_SDK}/FFMPEG/ffmpeg/COPYING*"
	DESTINATION "${CMAKE_INSTALL_PREFIX}/include/jderobot/ardrone/FFMPEG"
)



## Uninstall
add_custom_target(uninstall
	COMMAND ${CMAKE_COMMAND} -E remove_directory "${CMAKE_INSTALL_PREFIX}/lib/jderobot/ardrone"
	COMMAND ${CMAKE_COMMAND} -E remove_directory "${CMAKE_INSTALL_PREFIX}/include/jderobot/ardrone"
)


## pkg-config
set(prefix ${CMAKE_INSTALL_PREFIX})
set(libdir ${prefix}/lib/jderobot/ardrone)

set(includedir ${prefix}/include/jderobot/ardrone/FFMPEG/Includes)
configure_file(ffmpeg-0.8.pc.in ffmpeg-0.8.pc)

set(VERSION ${ARDRONE_SDK_FLAVOR})
set(includedir
	${prefix}/include/jderobot/ardrone/
	${prefix}/include/jderobot/ardrone/Soft/Common
	${prefix}/include/jderobot/ardrone/Soft/Lib
	${prefix}/include/jderobot/ardrone/VP_SDK
	${prefix}/include/jderobot/ardrone/VP_SDK/VP_Os/linux
	${prefix}/include/jderobot/ardrone/VP_SDK/VP_Api
)
configure_file(ardronelib.pc.in ardronelib.pc)

install(FILES
	"${CMAKE_BINARY_DIR}/ardronelib.pc"
	"${CMAKE_BINARY_DIR}/ffmpeg-0.8.pc"
	DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/"
)

add_custom_command(TARGET uninstall
	WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/"
	COMMAND ${CMAKE_COMMAND} -E remove ardronelib.pc ffmpeg-0.8.pc
)


## ---------------------------

# CPACK patch #1: undesired executables
#add_custom_command(TARGET ardronelib PRE_BUILD
#	COMMAND ${CMAKE_COMMAND} -E remove_directory "${ARDRONE_SDK}/VP_SDK/Build/PROD_MODE_gcc_4.3.3_Examples"
#	COMMENT "ardronelib: Delete undesired executables"
#)


# CPACK patch #2: requires at least one executable
file(WRITE dummy_main.c "int main(int argc, char** argv){return 0;}")
add_executable(dummy_main dummy_main.c)
INSTALL(FILES ${CMAKE_BINARY_DIR}/dummy_main DESTINATION /tmp OPTIONAL)


#
# Deb packages
#

# Determine current architecture
macro(dpkg_arch VAR_NAME)
        find_program(DPKG_PROGRAM dpkg DOC "dpkg program of Debian-based systems")
        if (DPKG_PROGRAM) 
          execute_process(
            COMMAND ${DPKG_PROGRAM} --print-architecture
            OUTPUT_VARIABLE ${VAR_NAME}
            OUTPUT_STRIP_TRAILING_WHITESPACE
          )
        endif(DPKG_PROGRAM)
endmacro(dpkg_arch)

include (InstallRequiredSystemLibraries)
SET (CPACK_GENERATOR "DEB")
SET (CPACK_SOURCE_GENERATOR TGZ)
SET (CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
SET (CPACK_SET_DESTDIR "on")
SET (CPACK_PACKAGING_INSTALL_PREFIX "/usr/local")


SET (VERSION 1.0.0)
# CPack version numbers for release tarball name.
SET (CPACK_PACKAGE_VERSION_MAJOR 1)
SET (CPACK_PACKAGE_VERSION_MINOR 0)
SET (CPACK_PACKAGE_VERSION_PATCH 0)
SET (CPACK_DEBIAN_PACKAGE_VERSION ${VERSION})


SET (CPACK_DEBIAN_PACKAGE_PRIORITY "extra")
SET (CPACK_DEBIAN_PACKAGE_SECTION "net")
dpkg_arch(CPACK_DEBIAN_PACKAGE_ARCHITECTURE)

#MESSAGE("Dependencias: ${DEPS}")

SET(CPACK_DEBIAN_PACKAGE_DEPENDS "daemontools, libsdl1.2-dev, libgtk2.0-dev, libxml2-dev, libudev-dev")

#set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA
#    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/cmake/postinst"
#    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/cmake/postrm")

SET (CPACK_PACKAGE_DESCRIPTION_SUMMARY "ArDrone SDK for JdeRobot")
SET (CPACK_PACKAGE_DESCRIPTION "ARDrone SDK for Jderobot description")

SET (CPACK_PACKAGE_CONTACT "Roberto Calvo <rocapal@gsyc.urjc.es>")
SET (CPACK_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}_${VERSION}_${CPACK_DEBIAN_PACKAGE_ARCHITECTURE}")

SET (CPACK_COMPONENTS_ALL Libraries ApplicationData)
include (CPack Documentation)
