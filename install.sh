#!/bin/bash

TEMP_FOLDER="deuxhuithuit-push-tmp"

function abort {
	echo "Installation aborted"
	exit 1
}

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

if [[ -z "${OP_AUTH_DOMAIN}" ]]; then
	echo "OP_AUTH_DOMAIN is not set in your environement variables."
	exit 1;
fi

if [[ -z "${OP_AUTH_EMAIL}" ]]; then
	echo "OP_AUTH_EMAIL is not set in your environement variables."
	exit 1;
fi

if [[ -z "${OP_AUTH_SECRET_KEY}" ]]; then
	echo "OP_AUTH_SECRET_KEY is not set in your environement variables."
	exit 1;
fi

if [[ -z "${OP_SVN_ENTRY}" ]]; then
	echo "OP_SVN_ENTRY is not set in your environement variables."
	exit 1;
fi

# make temp folder
mkdir -p $TEMP_FOLDER

# get dockerfile
curl -s https://raw.githubusercontent.com/DeuxHuitHuit/push/main/Dockerfile > $TEMP_FOLDER/Dockerfile

# get checkout.sh file
curl -s https://raw.githubusercontent.com/DeuxHuitHuit/push/main/checkout.sh > $TEMP_FOLDER/checkout.sh

# copy ssh folder to tmp
cp -R ~/.ssh/. $TEMP_FOLDER/ssh

# remove config since it can cause errors with ssh client
rm -rf $TEMP_FOLDER/ssh/config

# copy subversion folder to tmp
cp -R ~/.subversion/. $TEMP_FOLDER/subversion

# actual docker build
docker build -t deuxhuithuit/push $TEMP_FOLDER --build-arg opdomain="$OP_AUTH_DOMAIN " --build-arg opemail="$OP_AUTH_EMAIL" --build-arg opsecretkey="$OP_AUTH_SECRET_KEY" --build-arg opsvnentry="$OP_SVN_ENTRY"

# cleanup temp file
rm -rf $TEMP_FOLDER
