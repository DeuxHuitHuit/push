#!/bin/bash

SVN_URL=$1

# isolate the code so we do not colide with the system files
cd /root

# get op token
OP_TOKEN=$(op signin $OP_AUTH_DOMAIN $OP_AUTH_EMAIL $OP_AUTH_SECRET_KEY -r)

# get svn creds
OP_SVN_ACCOUNT=$(op get item $OP_SVN_ENTRY --fields username,password --session $OP_TOKEN)
SVN_USERNAME=$(echo $OP_SVN_ACCOUNT | jq -r ".username")
SVN_PASSWORD=$(echo $OP_SVN_ACCOUNT | jq -r ".password")

# checkout the project
svn co $SVN_URL project --username $SVN_USERNAME --password $SVN_PASSWORD

# save session token for other files
echo $OP_TOKEN > .opsession

# navigate to the project
cd project

# install npm packages
npm install
