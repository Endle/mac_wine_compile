#!/usr/bin/env bash

# TODO: Remove this hardcoced config
export WINE_SRC=$(pwd)/wine
export WINE_BUILD=$(pwd)/build

# Provided by Gcenx - https://github.com/Gcenx/homebrew-wine/issues/14#issuecomment-787525002
# Make dlopen() function like wine_dlopen()
export LDFLAGS="-Wl,-headerpad_max_install_names,-rpath,@loader_path/../,-rpath,/opt/local/lib,-rpath,/opt/X11/lib"

# Set headers
export C_INCLUDE_PATH="/opt/local/include"
export CPLUS_INCLUDE_PATH="$C_INCLUDE_PATH"
export OBJC_INCLUDE_PATH="$C_INCLUDE_PATH"

# Set library's
export LIBRARY_PATH="/opt/local/lib"

# Set Frameworks
export FRAMEWORK_SEARCH_PATHS="/opt/local/Library/Frameworks"

cd $WINE_BUILD
$WINE_SRC/configure         --enable-win64 \
                            --with-vkd3d \
                            --with-vulkan \
                            ac_cv_lib_soname_MoltenVK=libMoltenVK.dylib \
                            ac_cv_lib_soname_vulkan=

make -j$(sysctl -n hw.ncpu 2>/dev/null)
make install-lib DESTDIR="$PREFIXFOLDER"
