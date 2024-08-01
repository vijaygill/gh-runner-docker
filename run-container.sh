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

docker run -d --restart unless-stopped --user pi:pi --env GH_TOKEN="${GH_TOKEN}" --env RUNNER_NAME="${RUNNER_NAME}" --env GH_REPO="${GH_REPO}" -v /var/run/docker.sock:/var/run/docker.sock --network dockernet --name "gh-runner-${RUNNER_NAME}" gh-actions-runner
