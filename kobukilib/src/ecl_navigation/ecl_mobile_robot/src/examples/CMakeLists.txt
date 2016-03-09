###############################################################################
# Files
###############################################################################

add_executable(demo_partial_inverse partial_inverse.cpp)
target_link_libraries(demo_partial_inverse ${PROJECT_NAME} ${catkin_LIBRARIES})
install(TARGETS demo_partial_inverse RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
