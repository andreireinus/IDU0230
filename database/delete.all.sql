SET client_min_messages TO WARNING; 

DROP FUNCTION IF EXISTS fn_tooaegadeNimekiri (int) CASCADE;
DROP FUNCTION IF EXISTS fn_kasutajaProjektid (int) CASCADE;
DROP FUNCTION IF EXISTS fn_checkkood(integer) CASCADE;
DROP FUNCTION IF EXISTS fn_intToDigits(integer) CASCADE;
DROP FUNCTION IF EXISTS fn_calculateCheckSum(integer[], integer[]) CASCADE;
DROP FUNCTION IF EXISTS fn_lisaTooaeg(int, timestamp without time zone,  timestamp without time zone, varchar);

DROP VIEW IF EXISTS kliendi_nimekiri CASCADE;
DROP VIEW IF EXISTS tootajate_nimekiri CASCADE;
DROP VIEW IF EXISTS projekti_nimekiri CASCADE;

DROP TABLE IF EXISTS Tooaeg CASCADE;
DROP TABLE IF EXISTS Projekti_Liige;
DROP TABLE IF EXISTS Tootaja_Roll;
DROP TABLE IF EXISTS Tooaja_Seisund;
DROP TABLE IF EXISTS Projekt;
DROP TABLE IF EXISTS Projekti_Seisund;
DROP TABLE IF EXISTS Eraklient;
DROP TABLE IF EXISTS Ariklient;
DROP TABLE IF EXISTS Klient;
DROP TABLE IF EXISTS Tootaja;
DROP TABLE IF EXISTS Isik;
DROP TABLE IF EXISTS Organisatsioon;
DROP TABLE IF EXISTS Osapool;

DROP DOMAIN IF EXISTS d_telefon;
DROP DOMAIN IF EXISTS d_registrikood;
DROP DOMAIN IF EXISTS d_address;
DROP DOMAIN IF EXISTS d_e_mail;
DROP DOMAIN IF EXISTS d_tunnihind;
DROP DOMAIN IF EXISTS d_telefon;
DROP DOMAIN IF EXISTS d_nimi;
DROP DOMAIN IF EXISTS d_nimetus;
DROP DOMAIN IF EXISTS d_kirjeldus;
DROP DOMAIN IF EXISTS d_klassifikaatori_id;
