#!/bin/bash

source ../setup_env.sh

KEYCLOAK_SVC_IP=$(${KUBE_CLI} get service -o json | jq -r '.items[] | select(.metadata.name | test("keycloak")).spec.clusterIP')

echo "found keycloak service ip $KEYCLOAK_SVC_IP"
sed 's|KEYCLOAK_SVC_IP|'"${KEYCLOAK_SVC_IP}"'|' ./broker/keycloak-module.yaml > ./broker/keycloak-module-tmp.yaml

sed -i "s|BROKER_K8S_IMAGE|${BROKER_TAG}|g" ./broker/broker.yaml
sed -i "s|BROKER_INIT_IMAGE|${BROKER_INIT_TAG}|g" ./broker/broker.yaml

${KUBE_CLI} create -n ${OPR_NAMESPACE} -f ./broker/keycloak-module-tmp.yaml
${KUBE_CLI} create -n ${OPR_NAMESPACE} -f ./broker/broker.yaml
