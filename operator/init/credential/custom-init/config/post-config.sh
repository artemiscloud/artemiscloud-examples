#!/bin/bash

echo "############## Example Custom Script ###############"
echo "##                                                ##"
echo "##      This is an example configure script.      ##"
echo "##                                                ##"
echo "####################################################"

echo "#### The config dir locates at ${CONFIG_INSTANCE_DIR} ####"
ls ${CONFIG_INSTANCE_DIR}

echo Adding a new account "howard" with password "howard"
printf '\n' >> ${CONFIG_INSTANCE_DIR}/etc/artemis-users.properties 
echo "howard = howard" >> ${CONFIG_INSTANCE_DIR}/etc/artemis-users.properties

# visitor has role 'viewer'
# /etc/artemis-roles.properties
echo "adding howard role as viewer"
printf '\n' >> ${CONFIG_INSTANCE_DIR}/etc/artemis-roles.properties
echo "viewer = howard" >> ${CONFIG_INSTANCE_DIR}/etc/artemis-roles.properties

## Add role 'viewer' to HAWTIO_ROLE so that it can login to the console
sed -i "s|HAWTIO_ROLE='admin'|HAWTIO_ROLE='admin,viewer'|g" ${CONFIG_INSTANCE_DIR}/etc/artemis.profile

echo ------- original management.xml --------
cat ${CONFIG_INSTANCE_DIR}/etc/management.xml
echo ----------------------------------------

## Now do management.xml. Give role 'viewer' some limited permissions
# copy the files
cp /amq/scripts/management.xml ${CONFIG_INSTANCE_DIR}/etc

echo "#### Custom config done. ####"
