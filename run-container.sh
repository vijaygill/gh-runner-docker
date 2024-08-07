#!/bin/bash
if [ "${GH_REPO}" == "" ]
then
    echo "********** ERROR ***************************************"
    echo "GH_REPO missing. Set GH_REPO environment variable."
    echo "********** ERROR ***************************************"
    exit 1
fi

if [ "${GH_TOKEN}" == "" ]
then
    echo "********** ERROR ***************************************"
    echo "GH_TOKEN missing. Set GH_TOKEN environment variable."
    echo "Value can be obtained from 'Add New Runner' page."
    echo "********** ERROR ***************************************"
    exit 1
fi

if [ "${RUNNER_NAME}" == "" ]
then
    echo "********** ERROR ***************************************"
    echo "RUNNER_NAME missing. Set RUNNER_NAME environment variable."
    echo "********** ERROR ***************************************"
    exit 1
fi

UNAME=$(whoami)
USERID=$(id -u)
GRPID=$(cat /etc/group | grep docker| cut -d ":" -f3)

CONTAINER_NAME="gh-runner-${RUNNER_NAME}"

docker container kill ${CONTAINER_NAME}
docker container rm ${CONTAINER_NAME}

mkdir /tmp/${RUNNER_NAME}

docker run -d --restart unless-stopped  --user ${USERID}:${GRPID} --env GH_TOKEN="${GH_TOKEN}" --env RUNNER_NAME="${RUNNER_NAME}" --env GH_REPO="${GH_REPO}" -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/${RUNNER_NAME}:/tmp --network dockernet --name "${CONTAINER_NAME}" gh-actions-runner
