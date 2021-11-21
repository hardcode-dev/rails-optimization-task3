#!/bin/bash
set -e

DB_NAME=task_3_development

psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
 CREATE DATABASE $DB_NAME;
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres --dbname $DB_NAME <<-EOSQL
    CREATE extension pg_stat_statements;

    CREATE TABLE "pghero_query_stats" (
      "id" bigserial primary key,
      "database" text,
      "user" text,
      "query" text,
      "query_hash" bigint,
      "total_time" float,
      "calls" bigint,
      "captured_at" timestamp
    );
    CREATE INDEX ON "pghero_query_stats" ("database", "captured_at");
EOSQL
