#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm 
#=================================================
# 1. Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' openwrt/package/base-files/files/bin/config_generate

# 2. add additional feeds
echo "src-git kenzo https://github.com/kenzok8/openwrt-packages" >> openwrt/feeds.conf.default
echo "src-git small https://github.com/kenzok8/small" >> openwrt/feeds.conf.default
echo "src-git lienol https://github.com/Lienol/openwrt-package" >> openwrt/feeds.conf.default
cat openwrt/feeds.conf.default

# 3. Customize revision
sed -i "/echo \"DISTRIB_REVISION/ s/'\"/ (Compiled by zfdang on $(date '+%Y-%m-%d'))'\"/" openwrt/package/lean/default-settings/files/zzz-default-settings
cat openwrt/package/lean/default-settings/files/zzz-default-settings | grep DISTRIB_REVISION
