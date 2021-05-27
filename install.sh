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
mkdir -p deuxhuithuit-push-tmp/ssh

# Get dockerfile
#curl -s https://raw.githubusercontent.com/DeuxHuitHuit/push/main/Dockerfile?flush_cache=true > deuxhuithuit-push-tmp/Dockerfile

# copy ssh folder to tmp
cp -R ~/.ssh/. deuxhuithuit-push-tmp/ssh

# actual docker build
docker build -t deuxhuithuit/push deuxhuithuit-push-tmp

# cleanup temp file
# rm -rf deuxhuithuit-push-tmp
