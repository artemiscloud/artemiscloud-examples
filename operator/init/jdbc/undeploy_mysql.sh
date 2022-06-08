#!/bin/bash

source ../../setup_env.sh

${KUBE_CLI} delete -f mysql/mysql.yaml
