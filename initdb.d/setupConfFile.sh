#!/usr/bin/env bash

CONF_FILE=/usr/share/postgresql/postgresql.conf.sample

sed -ri "s/^#?(shared_preload_libraries)\s*=\s*''/\1 = 'pg_stat_statements'/" $CONF_FILE

echo 'default_statistics_target = 5000' >> $CONF_FILE
echo 'maintenance_work_mem = 4GB' >> $CONF_FILE
echo 'effective_cache_size = 68GB' >> $CONF_FILE
echo 'wal_buffers = 8MB' >> $CONF_FILE
echo 'shared_buffers = 30GB' >> $CONF_FILE
echo 'max_connections = 100' >> $CONF_FILE
echo 'work_mem = 64MB' >> $CONF_FILE

echo 'track_activity_query_size = 2048' >> $CONF_FILE
echo 'pg_stat_statements.track = all' >> $CONF_FILE
