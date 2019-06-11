#!/usr/bin/env sh
VER=v2.0.0
DIR=~/Downloads
MIRROR=https://github.com/nats-io/nats-server/releases/download/${VER}

dl()
{
    OS=$1
    PLATFORM=$2
    FILE=nats-server-${VER}-${OS}-${PLATFORM}.zip
    URL=$MIRROR/$FILE
    wget --quiet -O $DIR/$FILE $URL
    printf "  # %s\n  %s-%s: sha256:%s\n" $URL $OS $PLATFORM `sha256sum $DIR/$FILE | awk '{print $1}'`
}

printf "%s:\n" $VER
dl darwin amd64
dl linux 386
dl linux amd64
dl linux arm6
dl linux arm64
dl linux arm7
dl windows 386
dl windows amd64

