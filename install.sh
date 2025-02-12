#!/bin/bash
# set -eux

# Automatically re-run script under sudo if not root
if [ $(id -u) -ne 0 ]; then
    echo "Re-running script under sudo..."
    sudo --preserve-env "$0" "$@"
    exit
fi

if [ ! -f /etc/os-release ]; then
    echo "WARNING: This script only works on Ubuntu"
fi
source /etc/os-release
case ${UBUNTU_CODENAME} in
bionic | focal | jammy | noble)
    ;;
*)
    echo "WARNING: This script only works on Ubuntu bionic/focal/jammy/noble"
    exit 1
esac

apt-get -y update
echo 'tzdata tzdata/Areas select Asia' | debconf-set-selections
echo 'tzdata tzdata/Zones/Asia select Chongqing' | debconf-set-selections
DEBIAN_FRONTEND="noninteractive" apt install -y tzdata

apt-get -y install bash git cvs gzip bzip2 unzip tar perl sudo file time aria2 wget make minicom \
    lsb-release openssh-client vim tree u-boot-tools texinfo mediainfo \
    pkg-config libncurses* zlib1g-dev gcc g++ gawk patch libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev libxcb-xinerama0 libxcb-xinerama0-dev \
    libopenal-dev libuv1-dev bridge-utils ifplugd
apt-get install -f

apt-get -y install libjpeg8 libjpeg8-dev libjpeg-turbo8 libjpeg-turbo8-dev libvpx-dev \
    libgtk2.0-dev libgconf-2-4 gconf2 gconf2-common libx11-dev libxext-dev libxtst-dev \
    libxrender-dev libxmu-dev libxmuu-dev libxfixes-dev libxfixes3 libpangocairo-1.0-0 \
    libpangoft2-1.0-0 libdbus-1-dev libdbus-1-3 libusb-0.1-4 libusb-1.0-0-dev libusb-dev \
    libcurl4-openssl-dev libssh-dev libxml2-utils
apt-get -y install bison build-essential gperf flex ruby libasound2-dev \
    libbz2-dev libcap-dev libcups2-dev libdrm-dev
apt-get -y install libegl1-mesa-dev libnss3-dev libpci-dev libpulse-dev libudev-dev
apt-get -y install gyp ninja-build libssl-dev libelf-dev libxcursor-dev libxcomposite-dev \
    libxdamage-dev libxrandr-dev
apt-get -y install libfontconfig1-dev libxss-dev libwebp-dev libjsoncpp-dev libopus-dev \
    libminizip-dev libavutil-dev libavformat-dev libavcodec-dev libevent-dev
apt-get -y install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu gcc-arm-linux-gnueabihf \
    g++-arm-linux-gnueabihf qemu-user-static debootstrap whiptail bc device-tree-compiler \
    swig liblz4-tool mercurial subversion w3m graphviz genext2fs lib32stdc++6

# python
case "${UBUNTU_CODENAME}" in
jammy|noble)
	apt-get -y install python2-dev python2 python-dev-is-python3
        ;;
*)
        apt-get -y install python python-dev python3-dev
        ;;
esac

# libc6-dev-i386
# packages for rk linux-sdk
apt-get -y install expect expect-dev mtools \
    autoconf autotools-dev libsigsegv2 m4 intltool curl sed binutils libglib2.0-dev \
    libglade2-dev
if [ ${UBUNTU_CODENAME} = "bionic" ]; then
    apt-get -y install libqt4-dev python-linaro-image-tools linaro-image-tools
fi
apt-get -y install kmod cpio rsync zip patchelf live-build gettext zstd

# crosstool-ng
apt-get -y install lzip help2man libtool libtool-bin

# musl-dev
apt-get -y install musl-dev
[ -e /lib/libc.musl-x86_64.so.1 ] || ln -s /usr/lib/x86_64-linux-musl/libc.so /lib/libc.musl-x86_64.so.1

# misc tools
apt-get -y install net-tools silversearcher-ag strace
apt-get -y install pigz p7zip-full

# for sd_fuse
apt-get -y install parted udev fdisk e2fsprogs

# simg2img
case "${UBUNTU_CODENAME}" in
focal|jammy|noble)
        apt-get -y install android-sdk-libsparse-utils
        ;;
*)
        apt-get -y install android-tools-fsutils
        ;;
esac
case "${UBUNTU_CODENAME}" in
jammy|noble)
	apt-get -y install exfatprogs
	;;
*)
	apt-get -y install exfat-fuse exfat-utils
	;;
esac

# for wireguard
apt-get -y install libmnl-dev

# for android
apt-get -y install openjdk-8-jdk

# for openwrt23
apt-get -y install gcc-multilib

# for openwrt24
apt-get -y install python3-pyelftools

# install friendlyelec-toolchain
[ -d fa-toolchain ] || git clone https://github.com/friendlyarm/prebuilts.git -b master --depth 1 fa-toolchain
(cat fa-toolchain/gcc-x64/toolchain-4.9.3-armhf.tar.gz* | tar xz -C /)
(cat fa-toolchain/gcc-x64/toolchain-6.4-aarch64.tar.gz* | tar xz -C /)
(tar xf fa-toolchain/gcc-x64/toolchain-11.3-aarch64.tar.xz -C /)

rm -rf fa-toolchain

echo "all done."
