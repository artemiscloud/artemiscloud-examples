#!/bin/bash

source ../../setup_env.sh

rm keycloak-12.0.3.tar.gz

rm -r keycloak-12.0.3

${KUBE_CLI} delete -f keycloak_tmp.yaml

rm keycloak_tmp.yaml
