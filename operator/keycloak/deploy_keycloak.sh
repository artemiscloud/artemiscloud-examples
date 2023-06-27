#!/bin/bash
source ../setup_env.sh

KEYCLOAK_VER=19.0.2

function printUsage() {
  main_name=`basename "$0"`
  echo "Usage:"
  echo "${main_name} <quay.io user name> <quay.io repo name>"
}

params_ready=true
if [ -z "$1" ]
  then
    echo "Missing quay.io user name"
    params_ready=false
fi
if [ -z "$2" ]
  then
    echo "Missing quay.io repo name"
    params_ready=false
fi
if [ ${params_ready} = "false" ]
  then
    printUsage
    exit 1
fi

cd ./keycloak

wget https://github.com/keycloak/keycloak/releases/download/${KEYCLOAK_VER}/keycloak-legacy-${KEYCLOAK_VER}.tar.gz
tar xvf keycloak-legacy-${KEYCLOAK_VER}.tar.gz

docker build -t quay.io/$1/$2:latest .

docker push quay.io/$1/$2:latest

sed  's|QUAY_USER|'"$1"'|' keycloak.yaml > keycloak_tmp.yaml
sed -i 's|QUAY_REPO|'"$2"'|' keycloak_tmp.yaml

${KUBE_CLI} create -n ${OPR_NAMESPACE} -f keycloak_tmp.yaml

cd ..
