#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${BASEDIR}/setup_env.sh

BASE_URL="https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy"

${KUBE_CLI} delete -f ${BASE_URL}/crds/broker_activemqartemis_crd.yaml
${KUBE_CLI} delete -f ${BASE_URL}/crds/broker_activemqartemissecurity_crd.yaml
${KUBE_CLI} delete -f ${BASE_URL}/crds/broker_activemqartemisaddress_crd.yaml
${KUBE_CLI} delete -f ${BASE_URL}/crds/broker_activemqartemisscaledown_crd.yaml

${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/service_account.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/role.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/role_binding.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/election_role.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/election_role_binding.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/operator_config.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/operator.yaml

echo "Done."
