#!/bin/bash

source ../setup_env.sh

rm ./keycloak/keycloak-12.0.3.tar.gz

rm -r ./keycloak/keycloak-12.0.3

${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ./keycloak/keycloak_tmp.yaml

rm ./keycloak/keycloak_tmp.yaml
