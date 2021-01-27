#!/bin/bash

source setup_tool.sh

CUSTOM_INIT_IMAGE_TAG=$1

if [[ ${CUSTOM_INIT_IMAGE_TAG} == "" ]]; then
    echo "Please pass in image tag, e.g. quay.io/hgao/custom-init:broker-mysql-1.8"
    exit -1
fi
if [[ ! -f "custom-init/mysql-jdbc-driver/mysql-connector-java-8.0.23.jar" ]]; then
    echo "Downloading jdbc driver ..."
    curl https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.23/mysql-connector-java-8.0.23.jar \
     --output custom-init/mysql-jdbc-driver/mysql-connector-java-8.0.23.jar
fi

echo "Building custom init image using tag: ${CUSTOM_INIT_IMAGE_TAG}"

DB_SERVICE_IP=`$KUBE get service --field-selector metadata.name=mysql-service -o=jsonpath='{.items[0].spec.clusterIP}'`
DB_SERVICE_PORT=`$KUBE get service --field-selector metadata.name=mysql-service -o=jsonpath='{.items[0].spec.ports[0].port}'`

docker build --build-arg DB_USER=root \
             --build-arg DB_PASSWORD=password \
             --build-arg DB_SERVICE_IP=${DB_SERVICE_IP} \
             --build-arg DB_SERVICE_PORT=${DB_SERVICE_PORT} \
             --build-arg DB_NAME=amq_broker \
             -t ${CUSTOM_INIT_IMAGE_TAG} ./custom-init

docker push ${CUSTOM_INIT_IMAGE_TAG}
