#!/bin/bash

CONTAINER_NAME=$1
SVN_URL=$2

# get op token
OP_TOKEN=$(op signin $OP_AUTH_DOMAIN $OP_AUTH_EMAIL $OP_AUTH_SECRET_KEY -r)

# get svn creds
OP_SVN_ACCOUNT=$(op get item $OP_SVN_ENTRY --fields username,password --session $OP_TOKEN)
SVN_USERNAME=$(echo $OP_SVN_ACCOUNT | jq -r ".username")
SVN_PASSWORD=$(echo $OP_SVN_ACCOUNT | jq -r ".password")

# checkout the project
svn co $SVN_URL $CONTAINER_NAME --username $SVN_USERNAME --password $SVN_PASSWORD

# move to the project
cd $CONTAINER_NAME

# execute push file in project
bash push $OP_TOKEN
