#!/bin/bash

source ../../setup_env.sh

CUSTOM_INIT_IMAGE_TAG=$1

if [[ ${CUSTOM_INIT_IMAGE_TAG} == "" ]]; then
    echo "Please pass in image tag, e.g. quay.io/hgao/custom-init:credential-1"
    exit -1
fi

echo "Building custom init image using tag: ${CUSTOM_INIT_IMAGE_TAG}"

docker build -t ${CUSTOM_INIT_IMAGE_TAG} ./custom-init

docker push ${CUSTOM_INIT_IMAGE_TAG}
