#!/usr/bin/env bash

PGDATA=/var/lib/postgresql/data
CONF_FILE=$PGDATA/conf.d/nzroof.conf

sed -ri "s/^#?(shared_preload_libraries)\s*=\s*''/\1 = 'pg_stat_statements'/" $PGDATA/postgresql.conf
echo "include_dir = 'conf.d'" >> $PGDATA/postgresql.conf

mkdir -p /var/lib/postgresql/data/conf.d
chown postgres:postgres /var/lib/postgresql/data/conf.d
touch $CONF_FILE
chown postgres:postgres $CONF_FILE

echo 'default_statistics_target = 5000' >> $CONF_FILE
echo 'maintenance_work_mem = 4GB' >> $CONF_FILE
echo 'effective_cache_size = 68GB' >> $CONF_FILE
echo 'wal_buffers = 8MB' >> $CONF_FILE
echo 'shared_buffers = 30GB' >> $CONF_FILE
echo 'max_connections = 100' >> $CONF_FILE
echo 'work_mem = 64MB' >> $CONF_FILE

echo 'track_activity_query_size = 2048' >> $CONF_FILE
echo 'pg_stat_statements.track = all' >> $CONF_FILE

HOST_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}')

sed -i "/host    all             all             127.0.0.1\/32            trust/a host    all             all             $HOST_IP            md5" $PGDATA/pg_hba.conf
