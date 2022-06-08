#!/bin/bash

source ../../setup_env.sh

${KUBE_CLI} apply -f mysql/mysql.yaml

DB_POD_NAME=`${KUBE_CLI} get pod -o=jsonpath='{.items[0].metadata.name}'`
echo "mysql pod ${DB_POD_NAME} deployed."
echo "Done."
