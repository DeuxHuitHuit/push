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

read -p "🌎 1password domain: " -r

if [ -z "$REPLY" ] ;then
	abort
fi

OPDOMAIN=$REPLY

read -p "📧 1password email: " -r

if [ -z "$REPLY" ] ;then
	abort
fi

OPEMAIL=$REPLY

read -p "🔐 1password secret key: " -r

if [ -z "$REPLY" ] ;then
	abort
fi

OPSECRETKEY=$REPLY

# make temp folder
mkdir -p $TEMP_FOLDER
mkdir -p $TEMP_FOLDER/ssh

# Get dockerfile
curl -s https://raw.githubusercontent.com/DeuxHuitHuit/push/main/Dockerfile?flush_cache=true > $TEMP_FOLDER/Dockerfile

# copy ssh folder to tmp
cp -R ~/.ssh/. $TEMP_FOLDER/ssh

# copy subversion folder to tmp
cp -R ~/.subversion/. $TEMP_FOLDER/subversion

# actual docker build
docker build -t deuxhuithuit/push $TEMP_FOLDER --build-arg opdomain="$OPDOMAIN" --build-arg opemail="$OPEMAIL" --build-arg opsecretkey="$OPSECRETKEY"

# cleanup temp file
rm -rf $TEMP_FOLDER
