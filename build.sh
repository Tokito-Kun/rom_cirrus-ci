#!/bin/#!/usr/bin/env bash

export BUILD_TIME=$(date -u +%Y%m%d-%H%M)
#export SELINUX_IGNORE_NEVERALLOWS=true
#export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh && lunch voltage_munch-eng  && make -j$(nproc --all) target-files-package otatools
sign_target_files_apks -o -d keys out/target/product/munch/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip out/target/product/munch/signed-target-files.zip
ota_from_target_files -k keys/releasekey out/target/product/munch/signed-target-files.zip "out/target/product/munch/voltage-3.0-munch-$BUILD_TIME-UNOFFICIAL.zip"
export OUT_FILE="BUILD_DIR/out/target/product/munch/voltage-3.0-munch-$BUILD_TIME-UNOFFICIAL.zip"
