#!/usr/bin/env bash

# TODO: Remove this hardcoced config
export WINE_SRC=$(pwd)/wine
export WINE_BUILD=$(pwd)/build
mkdir -p $WINE_BUILD


export PATH="$(brew --prefix bison)/bin:$PATH"


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
                            --disable-option-checking \
--without-alsa \
--without-capi \
--with-cms \
--with-coreaudio \
--with-cups \
--with-curses \
--without-dbus \
--with-faudio \
--without-fontconfig \
--with-freetype \
--with-gcrypt \
--with-gettext \
--without-gettextpo \
--without-gphoto \
--with-gnutls \
--without-gsm \
--without-gssapi \
--with-gstreamer \
--without-hal \
--without-inotify \
--with-jpeg \
--with-jxrlib \
--without-krb5 \
--with-ldap \
--with-mingw \
--with-mpg123 \
--without-netapi \
--with-openal \
--with-opencl \
--with-opengl  \
--without-oss \
--with-pcap \
--with-png \
--with-pthread \
--without-pulse \
--without-quicktime \
--without-sane \
--with-sdl \
--with-tiff \
--without-udev \
--with-unwind \
--with-usb \
--without-v4l2 \
--without-vkd3d \
--without-xattr \
--with-xml \
--with-xslt \
--with-osmesa \
--with-xcomposite \
--with-xcursor \
--with-xfixes \
--with-xinerama \
--with-xinput \
--with-xinput2 \
--with-xrandr \
--with-xrender \
--with-xshape \
--with-xshm \
--with-xxf86vm \
--with-x \
--x-include=/opt/X11/include \
--x-lib=/opt/X11/lib

make -j$(sysctl -n hw.ncpu 2>/dev/null)
make install-lib DESTDIR="$PREFIXFOLDER"
