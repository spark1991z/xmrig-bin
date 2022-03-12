#!/bin/sh
_rzd_="\n========================================\n"
echo "${_rzd_}XMRIG Android Builder ($(uname -o)/$(uname -m))${_rzd_}"


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
mkdir -p xmrig/build
cd xmrig/build
cmake .. -DWITH_HWLOC=OFF
make -j$(nproc)
if [ -f xmrig ]; then
pf="$(uname -p)-$(uname -m)"
mv xmrig xmrig-${pf}
echo "\nBUILDING FINISHED\n"
ls -l xmrig-${pf}
fi


