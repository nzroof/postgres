FROM postgres:9.6

MAINTAINER Graeme Gellatly <graemeg@roof.co.nz>

ADD initdb.d/setupConfFile.sh /docker-entrypoint-initdb.d/setupConfFile.sh
ADD initdb.d/setupExtensions.sql /docker-entrypoint-initdb.d/setupExtensions.sql

RUN chmod 755 /docker-entrypoint-initdb.d/setupConfFile.sh
RUN chmod 755 /docker-entrypoint-initdb.d/setupExtensions.sql
