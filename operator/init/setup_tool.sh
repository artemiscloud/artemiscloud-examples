#!/bin/bash

if command -v kubectl &> /dev/null
then
    echo "using kubectl"
    export KUBE=kubectl
elif command -v oc &> /dev/null
then
    echo "using oc"
    export KUBE=oc
else
    echo "You need install kubectl (for minikube) or oc (for codeready)"
fi
