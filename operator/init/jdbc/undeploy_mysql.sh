#!/bin/bash

source ../../setup_env.sh

${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f mysql/mysql.yaml
