#!/bin/bash

KEYCLOAK_VER=19.0.2

source ../setup_env.sh

rm ./keycloak/keycloak-legacy-${KEYCLOAK_VER}.tar.gz

rm -r ./keycloak/keycloak-${KEYCLOAK_VER}

${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ./keycloak/keycloak_tmp.yaml

rm ./keycloak/keycloak_tmp.yaml
