#!/bin/bash

rm keycloak-12.0.3.tar.gz

rm -r keycloak-12.0.3

kubectl delete -f keycloak_tmp.yaml

rm keycloak_tmp.yaml


