#!/bin/bash

source ../setup_env.sh

${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ./broker/broker.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ./broker/keycloak-module-tmp.yaml

rm ./broker/keycloak-module-tmp.yaml
