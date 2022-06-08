# ArtemisCloud Operator Custom Init Image Example - JDBC

This example demonstrates how to use custom init image to configure
a broker instance deployed by [ActiveMQ Artemis broker operator](https://github.com/artemiscloud/activemq-artemis-operator) to run in a kubernetes/openshift cluster.

It configures a broker instance that uses [mysql](https://www.mysql.com/) database as it's persistence store.

This example should not be used in real productization environment.

## About ArtemisCloud Broker Operator Custom Init Image

Users can configure ActiveMQ Artemis Broker via custom resources ([examples](https://github.com/artemiscloud/activemq-artemis-operator/tree/master/deploy/examples)). The available configuration parameters are defined in CRD files.

In cases where users need some peculiar aspects of configuration that may be out of scope of CRD definitions,
they can just provide their own custom init image in the custom resource file. During deployment the operator installs the custom init image in broker's init container so it runs before the broker starts. The custom init image's config script will be called so it can adjust the broker configuration as needed.

## Prerequisites

1. You need to have access to a kubernetes cluster. For example you can install a [minikube](https://minikube.sigs.k8s.io/docs/) cluster.  You also need kubectl tool. (You can also choose [CodeReady](https://developers.redhat.com/products/codeready-containers/overview))

2. You need to have docker tool available for building the image in the example.

3. You need to have internet access in order to pull/push images in this example.

4. You need a container registry (e.g. [quay.io](https://quay.io) to push your custom init image to and pull it from.

## Example structure

In the current directory there are a few scripts to help you build and run this example.

There are three sub-directories that contains different kind of resources.

- the **mysql** directory has resources for deploying the database.
- the **custom-init** directory has resources to build the custom init image.
- the **broker** directory contains a broker custom resource file for creating a broker pod with the init image.

## Get started

1. Deploy the **mysql** database. Run:

    `$ ./deploy_mysql.sh`

The script deploys a **mysql** server and expose it as a service. It also creates a database called "**amq_broker**" which will be used by the broker as its persistence store. The root password is set to be "**password**".

Verify that the mysql pod is up and running. Run

    $ kubectl get pod
    NAME                               READY   STATUS    RESTARTS   AGE
    mysql-deployment-c67646cd4-qvxc2   1/1     Running   0          7s

Verify that mysql server has an empty '**amq_broker**' database created. For example you can get into mysql pod's shell and query with mysql tool:

    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | amq_broker         |
    | mysql              |
    | performance_schema |
    | sys                |
    +--------------------+
    5 rows in set (0.00 sec)


2. Deploy the Operator. Run:

    `$ ../../deploy_broker_operator.sh`

The script sets up proper service account and permissions for the broker operator and deploys the operator.

Verify that the operator is up and running. For example

    $ kubectl get pod
    NAME                                         READY   STATUS    RESTARTS   AGE
    activemq-artemis-operator-7b64475997-r6hls   1/1     Running   0          76s
    mysql-deployment-c67646cd4-qvxc2             1/1     Running   0          12m

3. Build the custom init image. Run:

    `$ ./build_custom_init.sh <tag>`

You need to pass in your expected tag as an argument to the script.
For example:

    `$ ./build_custom_init.sh quay.io/hgao/custom-init:broker-mysql-1.0`

The script will build the image, tag it and push it.

The example custom init image will be used in the [broker custom resource file](broker/broker_custom_init.yaml) to configure the broker to use the mysql service as it's persistence store. It copies the jdbc driver jar to broker's lib dir and changes its broker.xml so that it uses database instead of files as data store.

4. Deploy the broker custom resource. Run

    `$ ./deploy_broker_cr.sh <custom init tag>`

It needs the custom init tag built earlier as it's argument. For example

    `$ ./deploy_broker_cr.sh quay.io/hgao/custom-init:broker-mysql-1.0`

The script deploys the broker custom resource **./broker/broker_custom_init.yaml** which uses the custom init image for broker jdbc storage configuration.

Verify that the broker pod is up and running. For example

    $ kubectl get pod
    NAME                                         READY   STATUS    RESTARTS   AGE
    activemq-artemis-operator-7b64475997-r6hls   1/1     Running   0          31m
    ex-aao-ss-0                                  1/1     Running   0          8m1s
    mysql-deployment-c67646cd4-qvxc2             1/1     Running   0          42m

Verify that tables are created in mysql. You can log in to mysql pod's shell and do query, for example:

    $ kubectl exec mysql-deployment-c67646cd4-qvxc2 -ti -- /bin/bash

    # mysql -uroot -ppassword amq_broker
    mysql> show tables;
    +----------------------+
    | Tables_in_amq_broker |
    +----------------------+
    | bindings             |
    | large_messages       |
    | messages             |
    | page_store           |
    +----------------------+
    4 rows in set (0.00 sec)

5. Send some messages

To verify that messages are actually stored in database. Now use broker's cli tool to send a few messages.

    $ kubectl exec ex-aao-ss-0 -- /bin/bash -c "/home/jboss/amq-broker/bin/artemis producer \
      --user guest --password guest --url tcp://ex-aao-ss-0:61616 --message-count 100"

    amq-broker/bin/artemis producer --user guest --password guest --url tcp://ex-aao-ss-0:61616 --message-count 100
    OpenJDK 64-Bit Server VM warning: If the number of processors is expected to increase from one, then you should configure the number of parallel GC threads appropriately using -XX:ParallelGCThreads=N
    Connection brokerURL = tcp://ex-aao-ss-0:61616
    Producer ActiveMQQueue[TEST], thread=0 Started to calculate elapsed time ...

    Producer ActiveMQQueue[TEST], thread=0 Produced: 100 messages
    Producer ActiveMQQueue[TEST], thread=0 Elapsed time in second : 1 s
    Producer ActiveMQQueue[TEST], thread=0 Elapsed time in milli second : 1886 milli seconds

6. Verify the message records in mysql pod

Now login to mysql pod.

    $ kubectl exec mysql-deployment-c67646cd4-qvxc2 -ti -- /bin/bash

    $ mysql -uroot -ppassword amq_broker
    (log in messages omitted)

    mysql> select count(*) from messages;
    +----------+
    | count(*) |
    +----------+
    |      200 |
    +----------+
    1 row in set (0.00 sec)

As you can see there are internal records in the messages table.

7. Cleaning up

To clean up the example run the following scripts in order:

    $ ./undeploy_broker_cr.sh
    $ ../undeploy_broker_operator.sh
    $ ./undeploy_mysql.sh
