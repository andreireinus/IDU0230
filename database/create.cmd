@echo off
SET PATH=%PATH%;C:\Program Files\PostgreSQL\9.3\bin
SET PSQL_CREATE_OPTS=--dbname=idu0230 --host=localhost --port=5432 --username=postgres  --set client_encoding=UTF8
psql %PSQL_CREATE_OPTS% --file=create.sql