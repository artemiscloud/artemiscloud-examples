#!/bin/bash

##
## This script is used to initialize the test environment, including
## 1. Detect command line tool (kubectl or oc)
## 2. Various resources to be used in the example for deploying the Operator
## and broker images.
##
## - Operator deployment
##
## By default the script uses the latest tag on artemiscloud respository
## to install the operator (i.e. in deploy/install dir)
## If you want to use a specific commit/tag you can define the env variable
## OPERATOR_VERSION to override the default.
## (for example `export OPERATOR_VERSION=v1.0.7`)
##
## - Operator image
##
## By default the script uses the image specified in the operator yaml in deploy/install
## dir at the OPERATOR_VERSION source tag. To use a different Operator
## image, define the OPR_IMG_TAG (for example `export OPR_IMG_TAG=quay.io/artemiscloud/activemq-artemis-operator:dev.latest`)
##
## - Broker image
##
## By default the broker image uses the latest tag specified in the operator yaml
## To use a different image you can define the BROKER_TAG env var
## (for example `export BROKER_TAG=quay.io/artemiscloud/activemq-artemis-broker-kubernetes:dev.latest`)
##
## - Init image
##
## By default the init image uses the latest tag specified in the operator yaml
## To use a different init image you can define the BROKER_INIT_TAG env var
##
## - Operator namespace
##
## By default the operator and resources are deployed to default namespace.
## To use a different namespace you can define the OPR_NAMESPACE env var

function find_broker_image_tag {
  opr_ver=$1
  img_type=$2

  opr_yaml_url=https://raw.githubusercontent.com/artemiscloud/activemq-artemis-operator/${opr_ver}/config/manager/manager.yaml

  raw_opr_yaml="$(curl ${opr_yaml_url} 2>/dev/null)"

  if [[ $img_type == "init" ]]; then
    image_name_prefix="RELATED_IMAGE_ActiveMQ_Artemis_Broker_Init_"
  else
    image_name_prefix="RELATED_IMAGE_ActiveMQ_Artemis_Broker_Kubernetes_"
  fi

  img_key="none"
  while read -r line
  do
    if [[ $line == *${image_name_prefix}* ]]; then
      img_key="in"
      continue
    fi
    if [[ $img_key == "in" ]]; then
      if [[ $line == *value* ]]; then
        last_found_img=$line
      else
        img_key="none"
      fi
    fi
  done < <(echo "$raw_opr_yaml")
  last_found_img=$(echo $last_found_img | cut --delimiter=' ' --fields=2)
  echo "$last_found_img"
}

ARTEMISCLOUD_REPO=https://github.com/artemiscloud/activemq-artemis-operator.git

LATEST_TAG=$(git -c 'versionsort.suffix=-' ls-remote --exit-code --refs --sort='version:refname' --tags ${ARTEMISCLOUD_REPO} '*.*.*' | tail --lines=1 | cut --delimiter='/' --fields=3)

export OPERATOR_VERSION=${OPERATOR_VERSION:-${LATEST_TAG}}
echo "Using operator version ${OPERATOR_VERSION}"

#find out default broker/init image tags for ${OPERATOR_VERSION}
DEFAULT_BROKER_INIT_TAG=$(find_broker_image_tag ${OPERATOR_VERSION} "init")
DEFAULT_BROKER_TAG=$(find_broker_image_tag ${OPERATOR_VERSION} "broker")

export BROKER_INIT_TAG=${BROKER_INIT_TAG:-${DEFAULT_BROKER_INIT_TAG}}
export BROKER_TAG=${BROKER_TAG:-${DEFAULT_BROKER_TAG}}

echo "Using init image tag ${BROKER_INIT_TAG}"
echo "Using broker image tag ${BROKER_TAG}"

OPR_NAMESPACE=${OPR_NAMESPACE:-default}
echo "Using target namespace ${OPR_NAMESPACE}"

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

${KUBE_CLI} get namespace ${OPR_NAMESPACE} > /dev/null 2>&1
if [ $? -eq 0 ]
then
  echo "Namespace ${OPR_NAMESPACE} already exists."
else
  echo "Creating target namespace ${OPR_NAMESPACE}"
  ${KUBE_CLI} create namespace ${OPR_NAMESPACE}
fi
