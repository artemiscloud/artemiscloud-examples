#!/bin/bash

KEYCLOAK_SVC_IP=$(kubectl get service -o json | jq -r '.items[] | select(.metadata.name | test("keycloak")).spec.clusterIP')

echo "found keycloak service ip $KEYCLOAK_SVC_IP"
sed 's|KEYCLOAK_SVC_IP|'"${KEYCLOAK_SVC_IP}"'|' keycloak-module.yaml > keycloak-module-tmp.yaml

kubectl create -f keycloak-module-tmp.yaml
kubectl create -f broker.yaml


