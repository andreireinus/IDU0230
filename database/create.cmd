@echo off
SET PATH=%PATH%;C:\Program Files\PostgreSQL\9.3\bin

SET PGPASSWORD=PostOracle
SET PGUSERNAME=--username=k111881
SET PSQL_CREATE_OPTS=--host=apex.ttu.ee --port=7301 --set client_encoding=UTF8

:: psql %PSQL_CREATE_OPTS% %PGUSERNAME% --dbname=template1 --file=00.create.database.sql
:: psql %PSQL_CREATE_OPTS% %PGUSERNAME% --dbname=k111881_pmv --file=create.sql

:: SET PGPASSWORD=pmv_1234_jurist
:: SET PGUSERNAME=--username=pmv_jurist
psql %PSQL_CREATE_OPTS% %PGUSERNAME% --dbname=k111881_pmv --file=temp.sql

