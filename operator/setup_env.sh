#!/bin/bash
export OPERATOR_VERSION=v1.0.3

if command -v kubectl &> /dev/null
then
    echo "using kubectl"
    export KUBE_CLI=kubectl
elif command -v oc &> /dev/null
then
    echo "using oc"
    export KUBE_CLI=oc
else
    echo "You need install kubectl (for minikube) or oc (for codeready)"
fi
