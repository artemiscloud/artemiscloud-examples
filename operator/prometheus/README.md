# ArtemisCloud Operator Custom Init Image Example - Prometheus Plugin

This example demonstrates how to use [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator) to collect
metrics from brokers deployed by the artemiscloud operator.

This example is for demonstration purpose only and is not intended to be used in a real productization environment.

## Prerequisites

You need to have access to a kubernetes cluster. For example you can install a [minikube](https://minikube.sigs.k8s.io/docs/) cluster.  You also need kubectl tool. (You can also choose [CodeReady](https://developers.redhat.com/products/codeready-containers/overview))

## Example structure

In the current directory there are a few scripts to help you build and run this example and
there are three sub-directories that contains different kind of resources.

- the **broker** directory has resources for deploying the broker.
- the **prometheus** directory contains resources needed to deploy a prometheus pod.
- the **grafana** directory contains resources needed to deploy [grafana](https://grafana.com/oss/grafana/)

## Get started

1. Deploy the ArtemisCloud Operator. Run:

    `$ ../deploy_operator.sh`

Verify that the operator is up and running.

2. Deploy the broker custom resource. Run

    `$ ./deploy_broker_cr.sh`

The script deploys the broker custom resource **./broker/broker.yaml**.
The broker is configured to have Artemis metrics plugin enabled.

3. Deploy Prometheus service.

    `$ ./deploy_prometheus.sh`

It deploys prometheus operator and related resources to collect broker's metrics.
It creates a "NodePort" service to allow user to open up the prometheus console at http://<minikube ip>:30900
(assuming you are using minikube)

4. If you like to try grafana, then

    `$ ./deploy_grafana.sh`

Then use port-forward to access the grafana web console

    `$ kubectl port-forward service/grafana 3000:3000`

Then go to http://localhost:3000 to open up the console, login as admin (password admin),
from which you can add the broker data source and start exploring various metrics.
