#!/bin/sh
_os_=$(uname -o)
if [ "${_os_}" != "Android" ]; then
 echo "This script only for Android OS. Your OS: ${_os_}"
 exit
fi
_rzd_="\n========================================\n"
_build_r_=$(getprop ro.build.version.release)
_build_sdk_=$(getprop ro.build.version.sdk)
_arch_=$(uname -m)
_pf_=${_build_r_}-${_build_sdk_}-${_arch_}

echo "${_rzd_}XMRIG Build Script (XBS) (${_pf_})${_rzd_}"


echo "-- Step 1. Update & Install packages"
pkg update -y && pkg install git libuv cmake -y
echo "-- Step 2. Cloning repository"
git clone https://github.com/xmrig/xmrig
echo "-- Step 3. Changing donate level"
echo "\nREPLACE DEFAULT AND MINIMAL DONATE LEVEL AND PRESS CTRL+X,Y,ENTER\n"
echo "Press Enter to continue:"
read r
nano xmrig/src/donate.h
echo "Step 4. Building"
mkdir -p build
cd build
cmake ../xmrig -DWITH_HWLOC=OFF
make -j$(nproc)
if [ -f xmrig ]; then
cd ..
mv build/xmrig bin/xmrig-${_pf_}
#rm -rf build
echo "\nBUILDING FINISHED\n"
ls -l bin/xmrig-${_pf_}
fi


