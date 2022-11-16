#!/bin/bash

source ../setup_env.sh

${KUBE_CLI} create -n ${OPR_NAMESPACE} -f ./grafana/grafana.yaml
