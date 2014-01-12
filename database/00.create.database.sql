-- Ühendused kinni enne kui andmebaas kustutatakse
REVOKE CONNECT ON DATABASE k111881_pmv FROM public;
ALTER DATABASE k111881_pmv CONNECTION LIMIT 0;
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid() AND datname='k111881_pmv';

-- Andmebaasi kustutamine
DROP DATABASE IF EXISTS k111881_pmv;

-- Andmebaasi loomine
CREATE DATABASE k111881_pmv
	WITH
		TEMPLATE = template0
		ENCODING = 'UTF8'
		LC_COLLATE = 'et_EE.utf8'
		LC_CTYPE = 'et_EE.utf8';