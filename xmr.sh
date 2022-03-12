#!/bin/bash
POOL=pool.minexmr.com:4444
WALLET=87UXR53VnD28MjyxcuWQywDMVMx3bRCtgVcMPEHPPfG5fwHhk1y8CySfsAQc3ureBUfsFExBMRokuEpAfKtpt8AU5PzVZoe
THREADS=7
CPUAFF=0xFE #7654 3210
./xmrig \
-o $POOL \
-u $WALLET.m3 \
-p x \
-t $THREADS \
--cpu-affinity $CPUAFF \
#--no-huge-pages
