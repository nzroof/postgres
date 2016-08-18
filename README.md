# Postgres docker container with wale for backup

Currently supports Amazon S3 and Azure (beta) which must be specified by CONTAINER_TYPE.

Recommended use is with a docker env file. e.g .env/postgres.list

```
# For Postgres
POSTGRES_PASSWORD=MyPassword 

# For Wal-e
ACCESS_KEY=access-key # ACCESS KEY for S3, ACCOUNT NAME for Azure
SECRET_KEY=secret-key # SECRET ACCESS KEY for S3, ACCESS KEY for Azure
CONTAINER_TYPE=S3 # S3 or AZURE
BUCKET=s3://yourbucket/yourarchivedir

```

## Example usage
```
docker run -v pg95data:/var/lib/postgresql/data --env-file .env/postgres.list roofnz/postgres
```

The entry point scripts enable pg_trgm extension for text searching and change postgres configuration by creating a 10-general.conf and 20-archive.conf.  These are designed for a fairly grunty server, however creating your own conf file e.g. 30-my.conf in conf.d will override these