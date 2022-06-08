#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${BASEDIR}/setup_env.sh

${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/crds/broker_activemqartemis_crd.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/crds/broker_activemqartemisaddress_crd.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/crds/broker_activemqartemisscaledown_crd.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/crds/broker_activemqartemissecurity_crd.yaml

${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/service_account.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/role.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/role_binding.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/election_role.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/election_role_binding.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/operator_config.yaml
${KUBE_CLI} delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/operator.yaml

echo "Done."
