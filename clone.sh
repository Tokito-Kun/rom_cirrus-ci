#!/bin/bash

# repo
cd ~/
mkdir -p ~/.bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo
export PATH="${HOME}/.bin:${PATH}"

# Fetch Source
cd $CURRDIR
mkdir -p voltageos
cd voltageos
export BUILD_DIR=$(pwd)
echo -ne '\n' | repo init -u https://github.com/VoltageOS/manifest.git -b 14 --git-lfs
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
git clone https://$GH_TOKEN@github.com/Tokito-Kun/Private_keys.git keys
. build/envsetup.sh

# Latest chromium-webview
rm -r external/chromium-webview/prebuilt/arm
rm -r external/chromium-webview/prebuilt/arm64
rm -r external/chromium-webview/prebuilt/x86
rm -r external/chromium-webview/prebuilt/x86_64
git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_arm.git -b main external/chromium-webview/prebuilt/arm
git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_arm64.git -b main external/chromium-webview/prebuilt/arm64
git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_x86.git -b main external/chromium-webview/prebuilt/x86
git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_x86_64.git -b main external/chromium-webview/prebuilt/x86_64
cd $BUILD_DIR/external/chromium-webview/prebuilt/arm  && git lfs pull
cd $BUILD_DIR/external/chromium-webview/prebuilt/arm64  && git lfs pull
cd $BUILD_DIR/external/chromium-webview/prebuilt/x86  && git lfs pull
cd $BUILD_DIR/external/chromium-webview/prebuilt/x86_64  && git lfs pull
cd $BUILD_DIR

# Smart 5G patch
rm -r frameworks/base
git clone --depth=1 https://github.com/Tokito-Kun/voltage_frameworks_base.git -b 14 frameworks/base

rm -r packages/apps/Settings
git clone --depth=1 https://github.com/Tokito-Kun/voltage_packages_apps_Settings.git -b 14 packages/apps/Settings

# KProfiles
git clone --depth=1 https://github.com/KProfiles/android_packages_apps_Kprofiles packages/apps/KProfiles

# Prebuilt apps
git clone --depth=1 https://github.com/Tokito-Kun/android_packages_apps_Prebuilts.git -b 13 package/apps/Prebuilts

# Device Tree
git clone --depth=1 https://github.com/Tokito-Kun/device_xiaomi_munch.git -b fourteen device/xiaomi/munch
# Vendor Tree
git clone --depth=1 https://gitlab.com/itsurboimasarou/vendor_xiaomi_munch.git -b fourteen vendor/xiaomi/munch

# Nexus Kernel
git clone --depth=1 https://github.com/Tokito-Kun/nexus_kernel_xiaomi_sm8250 -b pelt-2 kernel/xiaomi/sm8250
echo "CONFIG_KSU=y" >> kernel/xiaomi/sm8250/arch/arm64/configs/munch_defconfi
