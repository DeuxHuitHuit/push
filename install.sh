#!/bin/bash

function hasCurl {
	result=$(command -v curl)
	if [ "$?" = "1" ]; then
		echo "You need curl to install push."
		exit 1
	fi
}

function hasDocker {
	result=$(command -v docker)
	if [ "$?" = "1" ]; then
		echo "You need Docker Desktop to use push. Please install it for your platform at https://www.docker.com/products/docker-desktop"
		exit 1
	fi
}

hasCurl
hasDocker

# make temp folder
mkdir -p deuxhuithuit-push-tmp

# Get dockerfile
curl -s https://raw.githubusercontent.com/DeuxHuitHuit/push/HEAD/Dockerfile > deuxhuithuit-push-tmp/Dockerfile

# copy ssh folder to tmp
cp -R ~/.ssh deuxhuithuit-push-tmp

# actual docker build
docker build -t deuxhuithuit/push:1.0.0 deuxhuithuit-push-tmp

# cleanup temp file
rm -rf deuxhuithuit-push-tmp
