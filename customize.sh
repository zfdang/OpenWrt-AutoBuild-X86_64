#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm 
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' openwrt/package/base-files/files/bin/config_generate


#2. Customize revision
sed -i "/echo \"DISTRIB_REVISION/ s/'\"/ (Compiled by zfdang on $(date '+%Y-%m-%d'))'\"/" openwrt/package/lean/default-settings/files/zzz-default-settings
