#!/usr/bin/env sh
VER=${1:-v2.1.0}
DIR=~/Downloads
MIRROR=https://github.com/nats-io/nats-server/releases/download/${VER}

dl()
{
    local os=$1
    local arch=$2
    local platform="${os}-${arch}"
    local file=nats-server-${VER}-${platform}.zip
    local lfile=$DIR/$file
    local url=$MIRROR/$file
    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

printf "  %s:\n" $VER
dl darwin amd64
dl linux 386
dl linux amd64
dl linux arm6
dl linux arm64
dl linux arm7
dl windows 386
dl windows amd64

