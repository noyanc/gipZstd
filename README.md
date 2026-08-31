# gipZstd

This repo contains Zstandard (zstd) for compressing and decompressing data at real time.

# Cloning

You should clone this repository under glistplugins (C:/dev/glist/glistplugins for Windows or ~/dev/glist/glistplugins for Linux and Mac) with `git clone https://github.com/GlistPlugins/gipZstd` command.

# Dependencies

zstd is downloaded by CMake while configuring, so a plain clone is all you need. It is pinned to a commit in `external/zstd.cmake` and lands in your app's build tree, not in the plugin directory. This needs CMake 3.18 or newer and network access on the first configure.

To build against a local zstd checkout instead of the pinned commit, pass its path to CMake:

	-DFETCHCONTENT_SOURCE_DIR_ZSTD=/path/to/zstd

Once a build directory has fetched it, `-DFETCHCONTENT_FULLY_DISCONNECTED=ON` keeps CMake from touching the network again.
