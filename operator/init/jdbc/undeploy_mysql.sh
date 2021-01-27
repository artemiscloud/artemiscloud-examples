#!/bin/bash

source ./setup_tool.sh

$KUBE delete -f mysql/mysql.yaml
