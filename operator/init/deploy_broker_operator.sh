#!/bin/bash

source setup_tool.sh

# deploy RBAC
$KUBE apply -f ./broker-operator/service_account.yaml
$KUBE apply -f ./broker-operator/role.yaml
$KUBE apply -f ./broker-operator/role_binding.yaml

# deploy crds
$KUBE apply -f ./broker-operator/crds/broker_activemqartemis_crd.yaml
$KUBE apply -f ./broker-operator/crds/broker_activemqartemisaddress_crd.yaml
$KUBE apply -f ./broker-operator/crds/broker_activemqartemisscaledown_crd.yaml

# Operator
$KUBE apply -f ./broker-operator/operator.yaml

echo "Done."
