#!/bin/sh
set +x
_arch_=$(uname -m)
_pf_=unknown
_rzd_="\n==========================================\n";
_sudo_=
_packages_=
case $(uname -o) in
"Android")
_build_r_=$(getprop ro.build.version.release)
_build_sdk_=$(getprop ro.build.version.sdk)
_pf_=android-${_build_sdk_}_${_build_r_}
_packages_="cmake clang libuv"
;;
"GNU/Linux")
if [ -f /etc/issue.net ]; then
_pf_=$(cat /etc/issue.net | tr "[:upper:]" "[:lower:]" | tr " " "_")
_sudo_=sudo
_packages_="cmake clang libuv1-dev libssl-dev"
fi
;;
esac

echo "${_rzd_}XMRig Build Script (${_pf_}-${_arch_})${_rzd_}"
read r

echo "-- Step 1. Update & Install packages"
echo "Packages: ${_packages_}"
${_sudo_} apt-get update || return
${_sudo_} apt-get install ${_packages_} -y || return
read r


echo "-- Step 2. Cloning repository"
git clone https://github.com/xmrig/xmrig
read r

echo "Step 3. Building"
mkdir -p build
cd build
cmake ../xmrig -DWITH_HWLOC=OFF
make -j$(nproc)
if [ -f xmrig ]; then
 cd ..
 mv build/xmrig bin/xmrig-${_pf_}-${_arch_}
 #rm -rf build
 echo "\nBUILDING FINISHED\n"
 ls -l bin/xmrig-${_pf_}-${_arch_}
fi


