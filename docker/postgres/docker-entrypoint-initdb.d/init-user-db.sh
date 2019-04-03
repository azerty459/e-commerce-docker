#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER $POSTGRES_USER_OTHER;
    ALTER USER $POSTGRES_USER_OTHER WITH PASSWORD '$POSTGRES_PASSWORD_OTHER';
    CREATE USER $POSTGRES_USER_SNOW;
    ALTER USER $POSTGRES_USER_SNOW WITH PASSWORD '$POSTGRES_PASSWORD_SNOW';
    CREATE DATABASE $DATABASE_NAME;
    GRANT ALL PRIVILEGES ON DATABASE $DATABASE_NAME TO $POSTGRES_USER_OTHER;
    ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT ALL PRIVILEGES ON DATABASE $DATABASE_NAME TO $POSTGRES_USER_SNOW;
    CREATE DATABASE sonarqube;
    GRANT ALL PRIVILEGES ON DATABASE sonarqube TO $POSTGRES_USER_OTHER;
    ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT ALL PRIVILEGES ON DATABASE sonarqube TO $POSTGRES_USER_SNOW;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    \c $DATABASE_NAME
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    CREATE EXTENSION IF NOT EXISTS "unaccent";
    CREATE OR REPLACE FUNCTION slugify("value" TEXT, "allow_unicode" BOOLEAN)
    RETURNS TEXT AS $$

      WITH "normalized" AS (
        SELECT CASE
          WHEN "allow_unicode" THEN "value"
          ELSE unaccent("value")
        END AS "value"
      )
      SELECT regexp_replace(
        trim(
          lower(
            regexp_replace(
              "value",
              E'[^\\w\\s-]',
              '',
              'gi'
            )
          )
        ),
        E'[-\\s]+', '-', 'gi'
      ) FROM "normalized";

    $$ LANGUAGE SQL STRICT IMMUTABLE;



EOSQL


