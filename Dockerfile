FROM postgres:9.5

MAINTAINER Graeme Gellatly <graemeg@roof.co.nz>

RUN apt-get update && apt-get install -y python-pip python-dev lzop pv daemontools
RUN easy_install wal-e

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV ACCESS_KEY # ACCESS KEY for S3, ACCOUNT NAME for Azure
ENV SECRET_KEY # SECRET ACCESS KEY for S3, ACCESS KEY for Azure
ENV CONTAINER_TYPE # S3 or AZURE
ENV BUCKET

ADD scripts/setup-wal-e.sh setup-wal-e.sh
RUN chmod +x ./setup-wal-e.sh  && ./setup-wal-e.sh

ADD initdb.d/setupConfFile.sh /docker-entrypoint-initdb.d/setupConfFile.sh
ADD initdb.d/setupExtensions.sql /docker-entrypoint-initdb.d/setupExtensions.sql

RUN chmod 755 /docker-entrypoint-initdb.d/setupConfFile.sh
RUN chmod 755 /docker-entrypoint-initdb.d/setupExtensions.sql
