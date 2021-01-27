#!/bin/bash

echo "############## Example Custom Script ###############"
echo "##                                                ##"
echo "##      This is an example configure script.      ##"
echo "##                                                ##"
echo "####################################################"

echo "#### The config dir locates at ${CONFIG_INSTANCE_DIR} ####"
ls ${CONFIG_INSTANCE_DIR}

echo "#### Copying mysql jdbc driver jar to ${CONFIG_INSTANCE_DIR}/lib ####"
cp /amq/mysql-jdbc-driver/mysql-connector-java-8.0.23.jar ${CONFIG_INSTANCE_DIR}/lib

echo "#### mysql user name ${DB_USER} password ${DB_PASSWORD}"
echo "#### mysql service ip is ${DB_SERVICE_IP} and port is ${DB_SERVICE_PORT} ####"
echo "#### database name: ${DB_NAME}"
echo "#### Adding jdbc configuration to broker.xml ####"
jdbcStore=""
jdbcStore="${jdbcStore}<store>\n"
jdbcStore="${jdbcStore}         <database-store>\n"
jdbcStore="${jdbcStore}            <jdbc-driver-class-name>com.mysql.cj.jdbc.Driver</jdbc-driver-class-name>\n"
jdbcStore="${jdbcStore}            <jdbc-connection-url>jdbc:mysql://${DB_USER}:${DB_PASSWORD}\@${DB_SERVICE_IP}:${DB_SERVICE_PORT}/${DB_NAME}</jdbc-connection-url>\n"
jdbcStore="${jdbcStore}            <message-table-name>MESSAGES</message-table-name>\n"
jdbcStore="${jdbcStore}            <bindings-table-name>BINDINGS</bindings-table-name>\n"
jdbcStore="${jdbcStore}            <large-message-table-name>LARGE_MESSAGES</large-message-table-name>\n"
jdbcStore="${jdbcStore}            <page-store-table-name>PAGE_STORE</page-store-table-name>\n"
jdbcStore="${jdbcStore}            <node-manager-store-table-name>NODE_MANAGER_STORE</node-manager-store-table-name>\n"
jdbcStore="${jdbcStore}            <jdbc-lock-expiration>20000</jdbc-lock-expiration>\n"
jdbcStore="${jdbcStore}            <jdbc-lock-renew-period>4000</jdbc-lock-renew-period>\n"
jdbcStore="${jdbcStore}            <jdbc-network-timeout>20000</jdbc-network-timeout>\n"
jdbcStore="${jdbcStore}         </database-store>\n"
jdbcStore="${jdbcStore}      </store>\n\n"

sed -i "s|<persistence-enabled>|${jdbcStore}      <persistence-enabled>|g" ${CONFIG_INSTANCE_DIR}/etc/broker.xml

echo "#### Custom config done. ####"
