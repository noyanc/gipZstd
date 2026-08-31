# To build against a local zstd checkout instead of the pinned commit:
#   cmake -DFETCHCONTENT_SOURCE_DIR_ZSTD=/path/to/zstd ...

include_guard(GLOBAL)

include(FetchContent)

# SOURCE_SUBDIR below needs 3.18. Fail here rather than somewhere inside the
# fetched project.
if(CMAKE_VERSION VERSION_LESS 3.18)
	message(FATAL_ERROR
			"gipZstd needs CMake 3.18 or newer to build zstd (found ${CMAKE_VERSION}).")
endif()

# Same commit gipZnet and gipMultiplayer build znet's compression against, so a
# project using both fetches zstd once.
set(ZSTD_GIT_REPOSITORY "https://github.com/facebook/zstd.git"
		CACHE STRING "Git repository to fetch zstd from")
set(ZSTD_GIT_TAG "48c0ed73625272cb7445183b5e256b5d0a130316"
		CACHE STRING "zstd commit, tag or branch to build against")

# Set as cache entries because zstd's CMakeLists asks for policy version 3.10,
# under which option() ignores a plain variable of the same name (CMP0077 OLD).
set(ZSTD_BUILD_PROGRAMS OFF CACHE BOOL "" FORCE)
set(ZSTD_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(ZSTD_BUILD_CONTRIB OFF CACHE BOOL "" FORCE)
set(ZSTD_BUILD_SHARED OFF CACHE BOOL "" FORCE)
set(ZSTD_BUILD_STATIC ON CACHE BOOL "" FORCE)
set(ZSTD_LEGACY_SUPPORT OFF CACHE BOOL "" FORCE)

# SOURCE_SUBDIR points at the CMake project; the repository root has none.
FetchContent_Declare(zstd
		GIT_REPOSITORY ${ZSTD_GIT_REPOSITORY}
		GIT_TAG ${ZSTD_GIT_TAG}
		SOURCE_SUBDIR build/cmake
)

# zstd force-sets CMAKE_BUILD_TYPE to Release when it is empty, which would
# quietly change how the engine and the app get compiled.
set(_gipzstd_saved_build_type "${CMAKE_BUILD_TYPE}")
FetchContent_MakeAvailable(zstd)
if(NOT _gipzstd_saved_build_type AND CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "${_gipzstd_saved_build_type}"
			CACHE STRING "Choose the type of build." FORCE)
endif()
unset(_gipzstd_saved_build_type)

# The engine is a shared library on some platforms, and zstd is linked into it.
set_target_properties(libzstd_static PROPERTIES POSITION_INDEPENDENT_CODE ON)
