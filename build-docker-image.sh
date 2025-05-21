#!/bin/bash

UNAME=$(whoami)
USERID=$(id -u)
GRPID=$(cat /etc/group | grep docker| cut -d ":" -f3)

RUNNER_URL=$(curl "https://github.com/actions/runner/releases/latest" -s -L -I -o /dev/null -w '%{url_effective}')
RUNNER_VER="${RUNNER_URL##*/v}"

docker build --build-arg=UNAME=${UNAME} --build-arg=UID=${USERID} --build-arg=GID=${GRPID} --build-arg=RUNNER_VER=${RUNNER_VER}  -t gh-actions-runner -f Dockerfile .

