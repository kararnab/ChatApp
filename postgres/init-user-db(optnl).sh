#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER ejabberd_user WITH PASSWORD 'yourpassword';
    CREATE DATABASE ejabberd_db;
    GRANT ALL PRIVILEGES ON DATABASE ejabberd_db TO ejabberd_user;
EOSQL