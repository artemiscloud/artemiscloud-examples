#!/bin/bash

source ../../setup_env.sh

${KUBE_CLI} create -n ${OPR_NAMESPACE} -f mysql/mysql.yaml

DB_POD_NAME=`${KUBE_CLI} get pod -n ${OPR_NAMESPACE} -o=jsonpath='{.items[0].metadata.name}'`
echo "mysql pod ${DB_POD_NAME} deployed."
echo "Done."
