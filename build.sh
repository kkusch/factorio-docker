#!/usr/bin/env bash
set -e
VERSION=$1

if [ -z ${VERSION} ]
then
    echo "Packages an arbitrary Factorio release."
    echo "---"
    echo "Usage: ./build.sh <version>"
    exit 1
fi

LOCAL_FILENAME=factorio_headless_x64.tar.xz
DOWNLOAD_URL=https://www.factorio.com/get-download/${VERSION}/headless/linux64

if [ ! -f $LOCAL_FILENAME ]; then
    wget ${DOWNLOAD_URL} -O ${LOCAL_FILENAME} || rm -f ${LOCAL_FILENAME}
fi
# Attempt to grab the requested release.

if [ $? -ne 0 ]
then
    exit 1
fi

docker build --build-arg factorio_version=${VERSION} -t kkusch91/factorio:${VERSION} -t kkusch91/factorio:latest .
rm $LOCAL_FILENAME