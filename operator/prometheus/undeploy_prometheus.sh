#!/bin/bash

source ../setup_env.sh

INSTALL_PROMETHEUS=${INSTALL_PROMETHEUS:-true}

# undeploy service monitor
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f prometheus/service_monitor.yaml

# undeploy prometheus rbac
sed -i "s/TARGET_NAMESPACE/${OPR_NAMESPACE}/g" prometheus/prometheus_rbac.yaml
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f prometheus/prometheus_rbac.yaml

# undeploy prometheus operator
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f prometheus/prometheus.yaml

# delete prometheus
${KUBE_CLI} delete -n ${OPR_NAMESPACE} -f prometheus/prometheus_service.yaml

if [[ ${INSTALL_PROMETHEUS} == "true" ]]; then
  # assuming k8s, install prometheus operator
  LATEST=$(curl -s https://api.github.com/repos/prometheus-operator/prometheus-operator/releases/latest | jq -cr .tag_name)
  curl -sL https://github.com/prometheus-operator/prometheus-operator/releases/download/${LATEST}/bundle.yaml | sed "s/namespace: default/namespace: ${OPR_NAMESPACE}/g" | ${KUBE_CLI} delete -f -
fi

echo "prometheus is uninstalled"
