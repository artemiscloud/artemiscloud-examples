#!/bin/bash

source ../../setup_env.sh

KEYCLOAK_SVC_IP=$(${KUBE_CLI} get service -o json | jq -r '.items[] | select(.metadata.name | test("keycloak")).spec.clusterIP')

echo "found keycloak service ip $KEYCLOAK_SVC_IP"
sed 's|KEYCLOAK_SVC_IP|'"${KEYCLOAK_SVC_IP}"'|' keycloak-module.yaml > keycloak-module-tmp.yaml

${KUBE_CLI} create -f keycloak-module-tmp.yaml
${KUBE_CLI} create -f broker.yaml
