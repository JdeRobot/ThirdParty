
project (youtubedl-jderobot)
cmake_minimum_required(VERSION 2.8)


###################
#                 #
#    INSTALL      #
#                 #
###################

install(FILES youtube-dl DESTINATION usr/local/bin/ )

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
SET (CPACK_SET_DESTDIR ON)
SET (CPACK_DEB_COMPONENT_INSTALL OFF)
SET (CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
SET (CPACK_PACKAGING_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")


# CPack version numbers for release tarball name.
SET (CPACK_PACKAGE_VERSION_MAJOR 0)
SET (CPACK_PACKAGE_VERSION_MINOR 1)
SET (CPACK_PACKAGE_VERSION_PATCH 0)
SET (CPACK_DEBIAN_PACKAGE_VERSION ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH})


SET (CPACK_DEBIAN_PACKAGE_PRIORITY "extra")
SET (CPACK_DEBIAN_PACKAGE_SECTION "net")
dpkg_arch(CPACK_DEBIAN_PACKAGE_ARCHITECTURE)

SET (CPACK_MONOLITHIC_INSTALL ON)

SET(CPACK_DEBIAN_PACKAGE_DEPENDS "${DEPS}")

set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA
    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/postinst"
    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/postrm")



SET (CPACK_PACKAGE_DESCRIPTION_SUMMARY
"Youtube-dl for JdeRobot")
SET (CPACK_PACKAGE_DESCRIPTION
"Youtube-dl forked from https://github.com/rg3/youtube-dl.git (version 2017.11.15) adding support to JdeRobot classes.
source: https://github.com/JdeRobot/ThirdParty/kurt")

## Patch: CPACK_PACKAGE_DESCRIPTION behavior is broken. Always use SUMMARY
SET (CPACK_PACKAGE_DESCRIPTION_SUMMARY ${CPACK_PACKAGE_DESCRIPTION})

SET (CPACK_PACKAGE_CONTACT "Aitor Martinez <aitor.martinez.fernandez@gmail.com>")
SET (CPACK_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}_${CPACK_DEBIAN_PACKAGE_VERSION}_${CPACK_DEBIAN_PACKAGE_ARCHITECTURE}")


include (CPack Documentation)




