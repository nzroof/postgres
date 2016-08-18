FROM postgres:9.5

MAINTAINER Graeme Gellatly <graemeg@roof.co.nz>

RUN apt-get update && apt-get install -y python-pip python-dev lzop pv daemontools
RUN easy_install wal-e

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD scripts/setup-wal-e.sh setup-wal-e.sh
RUN chmod +x ./setup-wal-e.sh  && ./setup-wal-e.sh

ADD initdb.d/setupConfFile.sh /docker-entrypoint-initdb.d/setupConfFile.sh
ADD initdb.d/setupExtensions.sql /docker-entrypoint-initdb.d/setupExtensions.sql

RUN chmod 755 /docker-entrypoint-initdb.d/setupConfFile.sh
RUN chmod 755 /docker-entrypoint-initdb.d/setupExtensions.sql
