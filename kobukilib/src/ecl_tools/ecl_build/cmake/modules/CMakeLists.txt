###############################################################################
# Files
###############################################################################

file(GLOB CMAKE_MODULES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cmake)

##############################################################################
# Installs
##############################################################################

# For convenience
file(COPY ${CMAKE_MODULES}
  DESTINATION ${CATKIN_DEVEL_PREFIX}/share/${PROJECT_NAME}/cmake/modules
)

install(FILES ${CMAKE_MODULES}
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/cmake/modules
)

