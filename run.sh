#!/bin/bash

set -e -x

docker build -t grafanatheus .
docker run --rm \
    --name grafanatheus \
    --network=host \
    --privileged \
    -v /proc:/host/proc \
    -v "$PWD/config:/config" \
    -v "$PWD/runtime:/runtime" \
    grafanatheus
