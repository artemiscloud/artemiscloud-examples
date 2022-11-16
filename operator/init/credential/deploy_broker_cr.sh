#!/bin/bash

source ../../setup_env.sh

CUSTOM_INIT_IMAGE_TAG=$1

if [[ ${CUSTOM_INIT_IMAGE_TAG} == "" ]]; then
    echo "Please pass in the custom image tag"
    exit -1
fi

sed -i "s|BROKER_K8S_IMAGE|${BROKER_TAG}|g" ./broker/broker_custom_init.yaml
sed -i "s|BROKER_INIT_IMAGE|${CUSTOM_INIT_IMAGE_TAG}|g" ./broker/broker_custom_init.yaml

cat ./broker/broker_custom_init.yaml

echo "Deploying broker ..."

${KUBE_CLI} create -n ${OPR_NAMESPACE} -f ./broker/broker_custom_init.yaml

echo "Done."
