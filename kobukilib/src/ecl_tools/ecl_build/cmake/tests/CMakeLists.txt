###############################################################################
# Files
###############################################################################

file(GLOB CMAKE_TESTS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

##############################################################################
# Installs
##############################################################################

# For convenience
file(COPY ${CMAKE_TESTS}
  DESTINATION ${CATKIN_DEVEL_PREFIX}/share/${PROJECT_NAME}/cmake/tests
)

install(FILES ${CMAKE_TESTS}
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/cmake/tests
)


