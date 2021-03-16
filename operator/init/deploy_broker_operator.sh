#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${BASEDIR}/setup_tool.sh

# deploy RBAC
$KUBE apply -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/service_account.yaml
$KUBE apply -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/role.yaml
$KUBE apply -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/role_binding.yaml

# deploy crds
$KUBE apply -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/crds/broker_activemqartemis_crd.yaml
$KUBE apply -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/crds/broker_activemqartemisaddress_crd.yaml
$KUBE apply -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/crds/broker_activemqartemisscaledown_crd.yaml

# Operator
curl ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/operator.yaml | sed 's|image.*|image: quay.io/artemiscloud/activemq-artemis-operator:dev.latest|g' | \
$KUBE apply -f -

echo "Done."
