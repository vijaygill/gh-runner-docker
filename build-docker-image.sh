#!/bin/bash

UNAME=$(whoami)
USERID=$(id -u)
GRPID=$(cat /etc/group | grep docker| cut -d ":" -f3)


docker build --build-arg=UNAME=${UNAME} --build-arg=UID=${USERID} --build-arg=GID=${GRPID} -t gh-actions-runner -f Dockerfile .

