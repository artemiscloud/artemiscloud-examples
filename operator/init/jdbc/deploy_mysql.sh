#!/bin/bash

source ../setup_tool.sh

$KUBE apply -f mysql/mysql.yaml

DB_POD_NAME=`$KUBE get pod -o=jsonpath='{.items[0].metadata.name}'`
echo "mysql pod ${DB_POD_NAME} deployed."
echo "Done."
