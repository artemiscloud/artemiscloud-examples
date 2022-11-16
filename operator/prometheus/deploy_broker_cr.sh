#!/bin/bash

source ../setup_env.sh

sed -i "s|BROKER_K8S_IMAGE|${BROKER_TAG}|g" ./broker/broker.yaml
sed -i "s|BROKER_INIT_IMAGE|${BROKER_INIT_TAG}|g" ./broker/broker.yaml

echo "Deploying broker ..."

cat ./broker/broker.yaml

${KUBE_CLI} create -n ${OPR_NAMESPACE} -f ./broker/broker.yaml

echo "Done."
