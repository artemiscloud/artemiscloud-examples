#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "basedir: $BASEDIR"

source ${BASEDIR}/setup_tool.sh

# undeploy Operator
$KUBE delete -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/operator.yaml

# undeploy crds
$KUBE delete -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/crds/broker_activemqartemis_crd.yaml
$KUBE delete -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/crds/broker_activemqartemisaddress_crd.yaml
$KUBE delete -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/crds/broker_activemqartemisscaledown_crd.yaml

# undeploy RBAC
$KUBE delete -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/service_account.yaml
$KUBE delete -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/role.yaml
$KUBE delete -f ${OPR_GITHUB_RAW_BASE}/${OPR_BR}/deploy/role_binding.yaml

echo "Done."

