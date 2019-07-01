#!/bin/bash

sudo apt-get install bison g++-multilib git gperf libxml2-utils make python-networkx zip
sudo apt-get install flex curl libncurses5-dev libssl-dev zlib1g-dev gawk minicom
sudo apt-get install openjdk-8-jdk

# uboot v2016
sudo apt-get install device-tree-compiler

# kernel release-4.4
sudo apt-get install liblz4-tool

# android 5
sudo apt-get install zlib1g:i386

# recommended
sudo apt-get install openssh-server vim
sudo apt-get install qemu-user-static
sudo apt-get install exfat-fuse exfat-utils p7zip-full tree

# build git-2.18+
sudo apt-get install autoconf
sudo apt-get install libcurl4-openssl-dev libssh-dev

# build x86-x64 kernel
sudo apt-get install pkg-config
sudo apt-get install libelf-dev

# build mtd-utils v2.0.2+
sudo apt-get install libtool

# virtualbox
sudo apt-get install libqt5core5a libqt5gui5 libqt5opengl5 \
	libqt5printsupport5 libqt5widgets5 libqt5x11extras5 libsdl1.2debian

# buildroot (rockchip)
sudo apt-get install texinfo
sudo apt-get install genext2fs

# crosstool-ng
sudo apt-get install lzip help2man libtool libtool-bin

# qemu
sudo apt-get install debootstrap

# mkimage
sudo apt-get install u-boot-tools
