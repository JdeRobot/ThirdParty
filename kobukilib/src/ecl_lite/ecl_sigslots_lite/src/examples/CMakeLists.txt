##############################################################################
# Files
##############################################################################

add_executable(demo_sigslots_lite sigslots.cpp)
install(TARGETS demo_sigslots_lite RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
