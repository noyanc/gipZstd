cmake_minimum_required (VERSION 3.10.2)

##### PLUGIN NAME #####
set(pluginname gipZstd)


##### PLUGIN PATHS #####
set(PLUGIN_DIR ${PLUGINS_DIR}/${pluginname})


##### PLUGIN SOURCES #####
list(APPEND PLUGIN_SRCS
			${PLUGIN_DIR}/src/gipZstd.cpp
)


##### ZSTD #####
# Fetched at configure time, see external/zstd.cmake for the pinned commit.
include(${PLUGIN_DIR}/external/zstd.cmake)


##### PLUGIN HEADERS #####
list(APPEND PLUGIN_INCLUDES
			${PLUGIN_DIR}/src
			${zstd_SOURCE_DIR}/lib
)

list(APPEND PLUGIN_LINKLIBS
		libzstd_static
)
