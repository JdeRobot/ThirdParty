SET(KOBUKI_DRIVER_LOCATION /usr/local CACHE PATH "")
SET(CMAKE_INSTALL_PREFIX /usr/local CACHE PATH "")

execute_process(COMMAND  ${CMAKE_CURRENT_SOURCE_DIR}/catkin_whitelist.sh
		INPUT_FILE catkin_whitelist
		OUTPUT_VARIABLE catkin_whitelist
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
		)
MESSAGE("${catkin_whitelist}")
SET(CATKIN_WHITELIST_PACKAGES "${catkin_whitelist}" CACHE STRINGS "")



