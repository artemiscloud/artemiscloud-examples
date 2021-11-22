#!/bin/bash

kubectl delete -f broker.yaml
kubectl delete -f keycloak-module-tmp.yaml

rm keycloak-module-tmp.yaml

