#!/bin/bash

CONTAINER_NAME=$1
SVN_URL=$2

# checkout the project
svn co $SVN_URL $CONTAINER_NAME

# move to the project
cd $CONTAINER_NAME

# execute push file in project
sh push
