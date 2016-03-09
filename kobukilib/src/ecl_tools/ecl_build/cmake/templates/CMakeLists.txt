###############################################################################
# Files
###############################################################################

file(GLOB CMAKE_TEMPLATES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cmake.in)

##############################################################################
# Installs
##############################################################################

# For convenience
file(COPY ${CMAKE_TEMPLATES}
  DESTINATION ${CATKIN_DEVEL_PREFIX}/share/${PROJECT_NAME}/cmake/templates
)

install(FILES ${CMAKE_TEMPLATES}
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/cmake/templates
)


