#!/usr/bin/env sh

set -eu

# Cleanup the previous 'build' directory
[ -d './build' ] && rm -rf './build'

# Create the 'build' directory and
# copy the required files to it

mkdir -p "./build/docs/asset"
cd ./build

cp -r ../docs/*.md docs/
cp -r ../docs/asset/. docs/asset/
cp -r ../LICENSE .
cp -r ../README.md .
cp -r ../src/compose.yaml .
cp -r ../src/config/default.env .env

tag=$(git tag --sort=committerdate | tail -1)

if [ -z "${tag}" ]; then
    tag=$(git rev-parse HEAD)
fi

sed -i.bak '/build:/d' compose.yaml
sed -i.bak '/context: .\//d' compose.yaml
sed -i.bak '/dockerfile: container\/send.Dockerfile/d' compose.yaml
sed -i.bak '/dockerfile: container\/receive.Dockerfile/d' compose.yaml
sed -i.bak "s|xc-copy-send:latest|ghcr.io/gameplayok/xc-copy-send:$tag|g" compose.yaml
sed -i.bak "s|xc-copy-receive:latest|ghcr.io/gameplayok/xc-copy-receive:$tag|g" compose.yaml

rm compose.yaml.bak
