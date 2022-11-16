#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${BASEDIR}/setup_env.sh

BASE_URL="https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/install"

${KUBE_CLI} delete -f ${BASE_URL}/010_crd_artemis.yaml
${KUBE_CLI} delete -f ${BASE_URL}/020_crd_artemis_security.yaml
${KUBE_CLI} delete -f ${BASE_URL}/030_crd_artemis_address.yaml
${KUBE_CLI} delete -f ${BASE_URL}/040_crd_artemis_scaledown.yaml

${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/050_service_account.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/060_namespace_role.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/070_namespace_role_binding.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/080_election_role.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/090_election_role_binding.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/100_operator_config.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f ${BASE_URL}/110_operator.yaml

echo "Done."
