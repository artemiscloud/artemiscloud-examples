#!/bin/bash

source ../setup_tool.sh

CUSTOM_INIT_IMAGE_TAG=$1

if [[ ${CUSTOM_INIT_IMAGE_TAG} == "" ]]; then
    echo "Please pass in the custom image tag"
    exit -1
fi

sed -i "s|initImage.*|initImage: ${CUSTOM_INIT_IMAGE_TAG}|g" ./broker/broker_custom_init.yaml

cat ./broker/broker_custom_init.yaml

echo "Deploying broker ..."

$KUBE apply -f ./broker/broker_custom_init.yaml

echo "Done."
