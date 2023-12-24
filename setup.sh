#!/bin/bash

export CURRDIR=$(pwd)

# Update & Install Req
sudo pacman -Syu --noconfirm --needed --noprogressbar
sudo pacman -Syu --noconfirm --needed --noprogressbar git-core git-lfs jq python gnupg ccache flex bison build-essential zip curl zlib1g-dev libssl-dev libc6-dev-i386 libncurses5 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig -y
yes | sudo pacman -Scc

# create swap
sudo swapon --show
sudo fallocate -l 20G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# ccache
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=~/ccache/vos/Munch/
ccache -cs
ccache -M 50G

# git config
git config --global user.email "93600306+Tokito-Kun@users.noreply.github.com"
git config --global user.name "Tokito-Kun"
