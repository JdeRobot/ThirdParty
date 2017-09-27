
project (kurt-jderobot)

# Change default install path
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set (CMAKE_INSTALL_PREFIX /opt/jderobot CACHE PATH "default install path" FORCE)
endif()

cmake_minimum_required(VERSION 2.8)


list(APPEND DEPS python-pil)


# list(APPEND uses ; separator. We need ,
STRING(REGEX REPLACE ";" ", " DEPS "${DEPS}")




###################
#                 #
#    INSTALL      #
#                 #
###################

install(DIRECTORY kurt

    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/python2.7/

    COMPONENT core

  )




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


if(DEFINED debug_deps)
MESSAGE("Dependencias: ${DEPS}")
MESSAGE("Dependencias_dev: ${DEPS_DEV}")
endif()

set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA
    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/postinst"
    "${CMAKE_CURRENT_SOURCE_DIR}/scripts/postrm")



SET (CPACK_PACKAGE_DESCRIPTION_SUMMARY
"Kurt for JdeRobot")
SET (CPACK_PACKAGE_DESCRIPTION
"Kurt forked from https://github.com/tjvr/kurt (version 2.0.7) adding support to JdeRobot classes.
source: https://github.com/JdeRobot/ThirdParty/kurt")

## Patch: CPACK_PACKAGE_DESCRIPTION behavior is broken. Always use SUMMARY
SET (CPACK_PACKAGE_DESCRIPTION_SUMMARY ${CPACK_PACKAGE_DESCRIPTION})

SET (CPACK_PACKAGE_CONTACT "Aitor Martinez <aitor.martinez.fernandez@gmail.com>")
SET (CPACK_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}_${CPACK_DEBIAN_PACKAGE_VERSION}_${CPACK_DEBIAN_PACKAGE_ARCHITECTURE}")


include (CPack Documentation)




