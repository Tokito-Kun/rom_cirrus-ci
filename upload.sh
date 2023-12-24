#/bin/#!/usr/bin/env bash

bash "$OUT_FILE" upload.sh
gh release create "v-$BUILD_TIME" "$OUT_FILE" --generate-notes
