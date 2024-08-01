#!/bin/bash

ssh-keyscan github.com >> ~/.ssh/known_hosts

echo "******************** Setup following key in your github account *******************************"
cat ./github-runner-key.pvt.pub
echo "***********************************************************************************************"

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


#./config.sh --unattended --disableupdate --url https://github.com/vijaygill/wg-ui-plus --token ${GH_TOKEN}
./config.sh --unattended --disableupdate --replace --url https://github.com/${GH_REPO} --name ${RUNNER_NAME} --token ${GH_TOKEN}
./run.sh
