#!/bin/bash

source ../setup_tool.sh

echo "Undeploying broker ..."

$KUBE delete -f ./broker/broker_custom_init.yaml

echo "Done."
