#!/bin/bash

source ./setup_tool.sh

# undeploy Operator
$KUBE delete -f ./broker-operator/operator.yaml

# undeploy crds
$KUBE delete -f ./broker-operator/crds/broker_activemqartemis_crd.yaml
$KUBE delete -f ./broker-operator/crds/broker_activemqartemisaddress_crd.yaml
$KUBE delete -f ./broker-operator/crds/broker_activemqartemisscaledown_crd.yaml

# undeploy RBAC
$KUBE delete -f ./broker-operator/service_account.yaml
$KUBE delete -f ./broker-operator/role.yaml
$KUBE delete -f ./broker-operator/role_binding.yaml

echo "Done."
