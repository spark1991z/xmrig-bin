#!/bin/bash

### OS
_arch_=$(uname -m)
_pf_=unknown
case $(uname -o) in
"Android")
_build_r_=$(getprop ro.build.version.release)
_build_sdk_=$(getprop ro.build.version.sdk)
_pf_=android_${_build_sdk_}_${_build_r_}
;;
"GNU/Linux")
if [ -f /etc/issue.net ]; then
_pf_=$(cat /etc/issue.net | tr "[:upper:]" "[:lower:]" | tr " " "_")
fi
;;
esac

if [ ! -f bin/xmrig-${_pf_}-${_arch_} ]; then
 echo "xmrig-${_pf_}-${_arch_}  not found. Try to build from sources via script."
 exit
fi

### Base
POOL=moscow01.hashvault.pro:443
WALLET=87UXR53VnD28MjyxcuWQywDMVMx3bRCtgVcMPEHPPfG5fwHhk1y8CySfsAQc3ureBUfsFExBMRokuEpAfKtpt8AU5PzVZoe
THREADS=6
CPUAFF=0xfc #7654 3210
WORKER=${_pf_}-${_arch_}
PASS_AS_WORKER=1

### Huge Pages
NO_HP=0
USE_HPJ=1

### Random X
RX_MODE=fast # light fast
USE_RX_1GP=1

### Flags
FLAGS=
if [ $NO_HP -eq 1 ]; then
 FLAGS+=" --no-huge-pages"
else
 if [ $USE_HPJ -eq 1 ]; then
  FLAGS+=" --huge-pages-jit"
 fi
fi
if [ "${RX_MODE}" != "" ]; then
 FLAGS+=" --randomx-mode=${RX_MODE}"
fi
if [ $USE_RX_1GP -eq 1 ]; then
 FLAGS+=" --randomx-1gb-pages"
fi

### XMRig
echo " * WORKER	${WORKER}"
WALLETWORKER=${WALLET}
PASSWORKER=x
if [ $PASS_AS_WORKER -eq 0 ]; then
 WALLETWORKER+=".${WORKER}"
else
 PASSWORKER=${WORKER}
fi

sudo bin/xmrig-${_pf_}-${_arch_} -o ${POOL} -u ${WALLETWORKER} -p ${PASSWORKER} -t $THREADS --cpu-affinity $CPUAFF ${FLAGS}

