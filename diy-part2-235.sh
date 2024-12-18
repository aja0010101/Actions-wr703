#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# rm -rf feeds/small/luci-app-passwall
# git clone https://github.com/simonchen/luci-app-passwall.git feeds/small/luci-app-passwall
# Modify default IP
# sed -i 's/192.168.1.1/192.168.9.1/g' package/base-files/files/bin/config_generate

rm -rf feeds/luci/themes/luci-theme-argon

git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

./scripts/feeds update -i
./scripts/feeds install -a
set -x

# sed -i "s/LEDE /We build $(TZ=UTC-8 date "+%Y.%m.%d") @ LEDE /g" lean/default-settings/files/zzz-default-settings
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate
