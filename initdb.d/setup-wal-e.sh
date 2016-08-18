#!/usr/bin/env bash

umask u=rwx,g=rx,o=
mkdir -p /etc/wal-e.d/env
if [ "$CONTAINER_TYPE" = "S3" ]; then
    echo "$SECRET_KEY" > /etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY
    echo "$ACCESS_KEY" > /etc/wal-e.d/env/AWS_ACCESS_KEY_ID
    echo "$BUCKET" > /etc/wal-e.d/env/WALE_S3_PREFIX
    echo "$AWS_REGION" > /etc/wal-e.d/env/AWS_REGION
elif [ "$CONTAINER_TYPE" = "AZURE" ]; then
    echo "$SECRET_KEY" > /etc/wal-e.d/env/WABS_ACCESS_KEY
    echo "$ACCESS_KEY" > /etc/wal-e.d/env/WABS_ACCOUNT_NAME
    echo "$BUCKET" > /etc/wal-e.d/env/WALE_WABS_PREFIX
fi

chown -R root:postgres /etc/wal-e.d
