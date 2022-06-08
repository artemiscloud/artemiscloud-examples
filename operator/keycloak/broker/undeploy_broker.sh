#!/bin/bash

source ../../setup_env.sh

${KUBE_CLI} delete -f broker.yaml
${KUBE_CLI} delete -f keycloak-module-tmp.yaml

rm keycloak-module-tmp.yaml
