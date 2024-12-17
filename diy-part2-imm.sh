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

# rm -rf feeds/luci/themes/luci-theme-argon

# git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
# git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# ./scripts/feeds update -i
# ./scripts/feeds install -a
# set -x

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# git_sparse_clone main https://github.com/Lienol/openwrt-package luci-app-filebrowser luci-app-ssr-mudb-server
# git_sparse_clone openwrt-18.06 https://github.com/immortalwrt/luci applications/luci-app-eqos
# git_sparse_clone main https://github.com/haiibo/packages luci-theme-atmaterial luci-theme-opentomcat luci-theme-netgear
# DDNS.to
#git_sparse_clone main https://github.com/linkease/nas-packages-luci luci/luci-app-ddnsto
#git_sparse_clone master https://github.com/linkease/nas-packages network/services/ddnsto

rm -rf feeds/luci/themes/luci-theme-argon
# curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh --no-sfe
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile
git clone https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale
# cd package
# mkdir kwrt-packages
# git init kwrt-packages
# cd kwrt-packages
# git remote add -f origin https://github.com/kiddin9/kwrt-packages
# git config core.sparseCheckout true

# echo "dufs/" >> .git/info/sparse-checkout
# echo "luci-app-dufs/" >> .git/info/sparse-checkout
# echo "tailscale/" >> .git/info/sparse-checkout
# echo "luci-app-tailscale/" >> .git/info/sparse-checkout
# echo "luci-app-chatgpt-web/" >> .git/info/sparse-checkout
# git pull origin main
# cd ..
# cd ..
# ./scripts/feeds update -i
# ./scripts/feeds install -a
# set -x

# cd package
# sed -i "s/LEDE /We build $(TZ=UTC-8 date "+%Y.%m.%d") @ LEDE /g" lean/default-settings/files/zzz-default-settings
# sed -i "s/LEDE/MI-R3G/" base-files/luci2/bin/config_generate
# sed -i "/firewall\.user/d" lean/default-settings/files/zzz-default-settings
# sed -i "s/192.168.1.1/192.168.123.1/g" base-files/luci2/bin/config_generate
# sed -i "/openwrt_luci/d" lean/default-settings/files/zzz-default-settings
#修改immortalwrt.lan关联IP
sed -i 's/192.168.1.1/192.168.123.1/g' $(find feeds/luci/modules/luci-mod-system -type f -name "flash.js")
# 固件版本名称自定义
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='ImmortalWrt By We $(date +"%Y%m%d") '/g" package/base-files/files/etc/openwrt_release
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate
# rm -rf feeds/packages/lang/golang
# git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
