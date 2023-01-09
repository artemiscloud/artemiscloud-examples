#!/bin/bash

source ../setup_env.sh

INSTALL_PROMETHEUS=${INSTALL_PROMETHEUS:-true}

#if [[ ${KUBE_CLI} == "kubectl" && ${INSTALL_PROMETHEUS} == "true" ]]; then
if [[ ${INSTALL_PROMETHEUS} == "true" ]]; then
  # assuming k8s, install prometheus operator
  LATEST=$(curl -s https://api.github.com/repos/prometheus-operator/prometheus-operator/releases/latest | jq -cr .tag_name)
  curl -sL https://github.com/prometheus-operator/prometheus-operator/releases/download/${LATEST}/bundle.yaml | sed "s/namespace: default/namespace: ${OPR_NAMESPACE}/g" | ${KUBE_CLI} create -n ${OPR_NAMESPACE} -f -
  ${KUBE_CLI} wait --for=condition=Ready pods -l app.kubernetes.io/name=prometheus-operator -n ${OPR_NAMESPACE}
fi

# deploy service monitor
${KUBE_CLI} create -n ${OPR_NAMESPACE} -f prometheus/service_monitor.yaml

# deploy prometheus rbac
sed -i "s/TARGET_NAMESPACE/${OPR_NAMESPACE}/g" prometheus/prometheus_rbac.yaml
${KUBE_CLI} create -n ${OPR_NAMESPACE} -f prometheus/prometheus_rbac.yaml

# deploy prometheus operator
${KUBE_CLI} create -n ${OPR_NAMESPACE} -f prometheus/prometheus.yaml

# expose prometheus
${KUBE_CLI} create -n ${OPR_NAMESPACE} -f prometheus/prometheus_service.yaml

echo "prometheus is set up"
