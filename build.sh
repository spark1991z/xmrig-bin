#!/bin/sh
set +x

### OS
_arch_=$(uname -m)
_pf_=unknown
_rzd_="\n==========================================\n";
_sudo_=
_packages_=
case $(uname -o) in
"Android")
_build_r_=$(getprop ro.build.version.release)
_build_sdk_=$(getprop ro.build.version.sdk)
_pf_=android_${_build_sdk_}_${_build_r_}
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

### Update & Install packages
${_sudo_} apt-get update || return
${_sudo_} apt-get install ${_packages_} -y || return

### Cloning XMRig repository
git clone https://github.com/xmrig/xmrig

### Building
mkdir -p build
cd build
cmake ../xmrig -DWITH_HWLOC=OFF || return
make -j$(nproc)
if [ -f xmrig ]; then
 cd ..
 mv build/xmrig bin/xmrig-${_pf_}-${_arch_}
 #rm -rf build
 echo "\nBUILDING FINISHED\n"
 ls -l bin/xmrig-${_pf_}-${_arch_}
fi

