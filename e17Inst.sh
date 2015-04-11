#!/bin/bash

echo "Started run install e17 script." && \
BLD_DIR=$(mktemp -d) && cd $BLD_DIR && \
echo "cd to build dir ${BLD_DIR}" && \
sudo -E apt-get update && \
echo "updated apt repos metadata" && \
sudo -E apt-get install build-essential wget gdb slim \
zlibc libc6-dev zlib1g-dev libpam-dev \
libfreetype6-dev libfontconfig1-dev libfribidi-dev xulrunner-dev \
libpng12-dev libjpeg8-dev libtiff4-dev libgif-dev librsvg2-dev \
libx11-dev libxext-dev libxrender-dev libxcomposite-dev \
libxdamage-dev libxfixes-dev libxrandr-dev libxinerama-dev \
libxss-dev libxp-dev libxcb-xtest0-dev libxcb-dpms0-dev \
libxcursor-dev libxcb-xprint0-dev libxkbfile-dev libxcb1-dev \
libxcb-keysyms1-dev libxcb-shape0-dev libssl-dev libcurl4-openssl-dev \
libudev-dev libdbus-1-dev libasound2-dev libpoppler-dev \
libraw-dev libspectre-dev liblua5.1-0-dev libwebp-dev \
libvlc-dev libxine-dev libgstreamer0.10-dev mesa-common-dev \
libgstreamer-plugins-base0.10-dev libgstreamer-plugins-bad0.10-dev && \
echo "Dep Libs installed successfully." && \
sudo -E apt-get install libgl1-mesa-dev && \ #ibgles2-mesa-dev libegl1-mesa-dev
echo "Installed libgl deps" && \
wget http://download.enlightenment.org/releases/enlightenment-0.17.0.tar.gz && \
echo "downloaded e17 bundle" && \
export PATH=/usr/local/bin:$PATH && \
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH && \
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH && \
export CFLAGS="-O3 -fvisibility=hidden -ffast-math -march=native -pipe" && \
echo "exported compile env vars" && \
for I in eina eet evas embryo ecore eio edje efreet e_dbus \
evas_generic_loaders ethumb eeze emotion elementary; do \
 tar zxf $I-1.7.4.tar.gz; \
 cd $I-1.7.4; \
 ./configure ${E17LIBS_OPTS} --disable-gnutls && make >> $I-make.log && su -c "make install >> $I-install.log"; \
 cd ..; \
done && \
echo "Installed all efl libs" && \
sudo ldconfig && \
tar zxf enlightenment-0.17.0.tar.gz && \
echo "Extracted enligtenment" && \
cd enlightenment-0.17.0 && \
echo "cd to enligtenment dir" && \
./configure ${E17_OPTS} && \
echo "enligtenment configured" && \
make >> E17-make.log && su -c "make install >> E17-install.log" && \
echo "enligtenment maked" && \
cd .. && \
echo "cd to parent dir" && \
sudo ln -s /usr/local/share/xsessions/enlightenment.desktop /usr/share/xsessions/enlightenment.desktop && \
echo "Maked desktop file" && \
echo "" && \
echo "      ------      " && \
echo "   SUCCESS   "
#apt-get remove gnome* pulseaudio* file-roller
#apt-get autoremove
