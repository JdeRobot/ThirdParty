cmake_minimum_required(VERSION 2.8)

project(kobuki)

SET (CPACK_GENERATOR "DEB")
SET (CPACK_PACKAGING_INSTALL_PREFIX "/usr/local")


# CPack version numbers for release tarball name.
SET (CPACK_PACKAGE_VERSION_MAJOR 0)
SET (CPACK_PACKAGE_VERSION_MINOR 1)
SET (CPACK_PACKAGE_VERSION_PATCH 0)
#SET (CPACK_DEBIAN_PACKAGE_VERSION ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH})

SET (CPACK_DEBIAN_PACKAGE_PRIORITY "extra")
SET (CPACK_DEBIAN_PACKAGE_SECTION "devel")

SET(CPACK_DEBIAN_PACKAGE_DEPENDS "python-wstool, python-catkin-pkg, python-empy, python-nose, python-setuptools, build-essential, libeigen3-dev")

SET (CPACK_PACKAGE_DESCRIPTION
"descripcion")

SET (CPACK_PACKAGE_CONTACT "Topo <topo@gsyc.urjc.es>")

include (CPack Documentation)
