#!/bin/bash

source ./setup_tool.sh

echo "Undeploying broker ..."

$KUBE delete -f ./broker-operator/example/broker_custom_init.yaml

echo "Done."
