FROM postgres:9.5

MAINTAINER Graeme Gellatly <graemeg@roof.co.nz>

RUN apt-get update && apt-get install -y python3 python3-pip python3-dev lzop pv daemontools cron
RUN easy_install3 wal-e

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD initdb.d/setupConfFile.sh /docker-entrypoint-initdb.d/setupConfFile.sh
ADD initdb.d/setupExtensions.sql /docker-entrypoint-initdb.d/setupExtensions.sql
ADD initdb.d/setup-wal-e.sh /docker-entrypoint-initdb.d/setup-wal-e.sh

RUN chmod 755 /docker-entrypoint-initdb.d/setupConfFile.sh
RUN chmod 755 /docker-entrypoint-initdb.d/setupExtensions.sql
RUN chmod 755 /docker-entrypoint-initdb.d/setup-wal-e.sh
