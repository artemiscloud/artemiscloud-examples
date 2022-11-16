#!/bin/bash

source ../setup_env.sh

echo "Undeploying broker ..."

${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ./broker/broker.yaml

echo "Done."
