#!/usr/bin/env sh
DIR=~/Downloads

dl()
{
    local app=$1
    local ver=$2
    local os=$3
    local arch=$4
    local platform="${os}-${arch}"
    local mirror=https://github.com/nats-io/${app}/releases/download/${ver}
    local file=${app}-${ver}-${platform}.zip
    local lfile=$DIR/$file
    local url=$mirror/$file
    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dlapp() {
    local app=$1
    local ver=$2
    printf "  %s:\n" $ver
    dl $app $ver darwin amd64
    dl $app $ver linux 386
    dl $app $ver linux amd64
    dl $app $ver linux arm6
    dl $app $ver linux arm64
    dl $app $ver linux arm7
    dl $app $ver windows 386
    dl $app $ver windows amd64
}

dlapp nats-server ${1:-v2.1.0}

