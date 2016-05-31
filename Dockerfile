FROM postgres

MAINTAINER Graeme Gellatly <graemeg@roof.co.nz>

ENV CONF_DIR /usr/share/postgresql/
ENV CONF_FILE $CONF_DIRpostgresql.conf.sample
# Enable pg_stat_statements

ADD initdb.d/setupConfFile.sh /docker-entrypoint-initdb.d/setupConfFile.sh
ADD initdb.d/setupExtensions.sql /docker-entrypoint-initdb.d/setupExtensions.sql

RUN chmod 755 /docker-entrypoint-initdb.d/setupConfFile.sh
RUN chmod 755 /docker-entrypoint-initdb.d/setupExtensions.sql
