FROM postgres

MAINTAINER Graeme Gellatly <graemeg@roof.co.nz>

ENV CONF_DIR /usr/share/postgresql/
ENV CONF_FILE $CONF_DIRpostgresql.conf.sample
# Enable pg_stat_statements

ADD initdb.d /docker-entrypoint-initdb.d/