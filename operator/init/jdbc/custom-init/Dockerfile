FROM quay.io/artemiscloud/activemq-artemis-broker-init:0.2.3
#FROM quay.io/hgao/init-container:specialchar3

ADD mysql-jdbc-driver /amq/mysql-jdbc-driver
ADD config /amq/scripts

RUN ls /amq
RUN ls /amq/mysql-jdbc-driver
RUN ls /amq/scripts

ARG DB_USER
ARG DB_PASSWORD
ARG DB_SERVICE_IP
ARG DB_SERVICE_PORT
ARG DB_NAME

ENV DB_USER=${DB_USER}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV DB_SERVICE_IP=${DB_SERVICE_IP}
ENV DB_SERVICE_PORT=${DB_SERVICE_PORT}
ENV DB_NAME=${DB_NAME}

RUN echo DB_USER: ${DB_USER}
RUN echo DB_PASSWORD: ${DB_PASSWORD}
RUN echo DB_SERVICE_IP: ${DB_SERVICE_IP}
RUN echo DB_SERVICE_PORT: ${DB_SERVICE_PORT}
RUN echo DB_NAME: ${DB_NAME}
