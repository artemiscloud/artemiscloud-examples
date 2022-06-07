#!/bin/bash

OPERATOR_VERSION=v1.0.3

kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/crds/broker_activemqartemis_crd.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/crds/broker_activemqartemisaddress_crd.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/crds/broker_activemqartemisscaledown_crd.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/crds/broker_activemqartemissecurity_crd.yaml

kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/service_account.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/role.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/role_binding.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/election_role.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/election_role_binding.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/operator_config.yaml
kubectl delete -f https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${OPERATOR_VERSION}/deploy/operator.yaml
