#!/usr/bin/env bash

PGDATA=/var/lib/postgresql/data

sed -ri "s/^#?(shared_preload_libraries)\s*=\s*''/\1 = 'pg_stat_statements'/" $PGDATA/postgresql.conf
echo "include_dir = 'conf.d'" >> $PGDATA/postgresql.conf

mkdir -p /var/lib/postgresql/data/conf.d
chown postgres:postgres /var/lib/postgresql/data/conf.d
touch $CONF_FILE
chown postgres:postgres $CONF_FILE

# Set General Tuning Config
GEN_CONF_FILE=$PGDATA/conf.d/10-general.conf
echo 'default_statistics_target = 5000' >> $GEN_CONF_FILE
echo 'maintenance_work_mem = 4GB' >> $GEN_CONF_FILE
echo 'effective_cache_size = 68GB' >> $GEN_CONF_FILE
echo 'wal_buffers = 8MB' >> $GEN_CONF_FILE
echo 'shared_buffers = 30GB' >> $GEN_CONF_FILE
echo 'max_connections = 100' >> $GEN_CONF_FILE
echo 'work_mem = 64MB' >> $GEN_CONF_FILE

echo 'track_activity_query_size = 2048' >> $GEN_CONF_FILE
echo 'pg_stat_statements.track = all' >> $GEN_CONF_FILE

# Turn on WAL Archiving
WAL_CONF_FILE=$PGDATA/conf.d/20-wal.conf
echo 'wal_level = archive' >> $WAL_CONF_FILE
echo 'archive_mode = on' >> $WAL_CONF_FILE
echo "archive_command = 'envdir /etc/wal-e.d/env /usr/local/bin/wal-e wal-push %p'" >> $WAL_CONF_FILE
echo "archive_timeout = 60" >> $WAL_CONF_FILE

# Allow docker network connections
HOST_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}')

sed -i "/host    all             all             127.0.0.1\/32            trust/a host    all             all             $HOST_IP            md5" $PGDATA/pg_hba.conf
