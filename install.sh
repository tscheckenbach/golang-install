#!/bin/bash
# Golang-Install-For-Linux
# Project Home Page:
# https://github.com/skiy/golang-install
#
# Author: Skiychan <dev@skiy.net>
# Link: https://www.skiy.net

set -e

RELEASES_URL="https://golang.google.cn/dl/"

# Get OS bit
initArch() {
    ARCH=$(uname -m)
    case $ARCH in
        amd64) ARCH="amd64";;
        x86_64) ARCH="amd64";;
        i386) ARCH="386";;
        *) echo -e "\033[1;31mArchitecture ${ARCH} is not supported by this installation script\033[0m"; exit 1;;
    esac
    echo "ARCH = $ARCH"
}

# Get OS version
initOS() {
    OS=$(uname | tr '[:upper:]' '[:lower:]')
    case "$OS" in
        darwin) OS='darwin';;
        linux) OS='linux';;
        freebsd) OS='freebsd';;
#        mingw*) OS='windows';;
#        msys*) OS='windows';;
        *) echo -e "\033[1;31mOS ${OS} is not supported by this installation script\033[0m"; exit 1;;
    esac
    echo "OS = $OS"
}

# Compare Version
compareVersion() {
    OLD_VERSION="none"
    NEW_VERSION="$1"
    if test -x "$(command -v go)"; then
        OLD_VERSION="$(go version | awk '{print $3}')"
    fi
    if [ "$OLD_VERSION" = "$NEW_VERSION" ]; then
       echo -e "\033[1;31mYou have installed this version: $OLD_VERSION\033[0m"; exit 1;
    fi

printf "
Current version: \033[1;33m$OLD_VERSION\033[0m 
Target version: \033[1;33m$NEW_VERSION\033[0m
"
}

# Check if user is root
checkRoot() {
    ROOT=$(id -u)
    case "$ROOT" in
        0) ROOT='root';;
        *) echo -e "\033[1;31mError: You must be root to run this script\033[0m"; exit 1;;
    esac
}

# Download go file
downloadFile() {
    url="$1"
    destination="$2"

    echo "Fetching $url.."
    if test -x "$(command -v curl)"; then
        code=$(curl -s -w '%{http_code}' -L "$url" -o "$destination")
    elif test -x "$(command -v wget)"; then
        code=$(wget -q -O "$destination" --server-response "$url" 2>&1 | awk '/^  HTTP/{print $2}' | tail -1)
    else
        echo "Neither curl nor wget was available to perform http requests."
        exit 1
    fi

    if [ "$code" != 200 ]; then
        echo "Request failed with code $code"
        exit 1
    fi
}

# Set Golang Environment
setEnvironment() {
    profile="$1"
    if [ -z "`grep 'export\sGOROOT' $profile`" ];then
        echo "export GOROOT=/usr/local/go" >> $profile
    fi
    if [ -z "`grep 'export\sGOPATH' $profile`" ];then
        echo "export GOPATH=/data/go" >> $profile
    fi
    if [ -z "`grep 'export\sGOBIN' $profile`" ];then
        echo "gopath:$GOPATH"
        echo "export GOBIN=$GOPATH/bin" >> $profile
    fi   
    if [ -z "`grep '\$GOROOT/bin:\$GOBIN' $profile`" ];then
        echo "export PATH=\$GOROOT/bin:\$GOBIN:\$PATH" >> $profile
    fi  
}

# Printf Version Info
clear
printf "
###############################################################
###  Golang Install For Linux
###  Author Skiychan<dev@skiy.net>
###  Link https://www.skiy.net 
###############################################################
\n"

# identify platform based on uname output
checkRoot
initArch
initOS

# DIY version
if [ -n "$1" ] ;then
    RELEASE_TAG="go$1"
fi

# if RELEASE_TAG was not provided, assume latest
if [ -z "$RELEASE_TAG" ]; then
    RELEASE_TAG="$(curl -sL $RELEASES_URL | sed -n '/toggleVisible/p' | head -n 1 | cut -d '"' -f 4)"
fi
echo "Release Tag = $RELEASE_TAG"

# Compare Version
compareVersion $RELEASE_TAG

printf "
###############################################################
###  System: %s 
###  Bit: %s 
###  Version: %s 
###############################################################
\n" $OS $ARCH $RELEASE_TAG

# Download File
BINARY_URL="https://dl.google.com/go/$RELEASE_TAG.$OS-$ARCH.tar.gz"
DOWNLOAD_FILE="$(mktemp).tar.gz"
downloadFile "$BINARY_URL" "$DOWNLOAD_FILE"

# Tar File and Move File
tar -C /usr/local/ -zxf $DOWNLOAD_FILE && \
rm $DOWNLOAD_FILE -rf
 
# Create GOPATH Folder
mkdir -p /data/go

# Set Environmental for Golang
PROFILE="/etc/profile"
setEnvironment "$PROFILE"
 
# Make Env Is Enable
. $PROFILE
go env
go version
 
# Printf Tip
printf "
###############################################################
# Install success, please execute again \e[1;33msource $PROFILE\e[0m
###############################################################
"