\i delete.all.sql

\i 00.schema.domains.sql
\i 01.schema.tables.sql
\i 02.schema.views.sql
\i 03.schema.functions.sql

\i 10.data.classificators.sql


INSERT INTO Osapool (Aadress, Telefon, Email) VALUES ('Aadress 1', '12345', 'andrei.reinus@gmail.com');
INSERT INTO Isik (Isik_ID, Eesnimi, Perekonnanimi) VALUES (currval('osapool_osapool_id_seq'), 'Andrei', 'Reinus');
INSERT INTO Tootaja (tootaja_id, Kasutajanimi, Parool) VALUES (currval('osapool_osapool_id_seq'), 'a', 'b');

INSERT INTO Osapool (Aadress, Telefon, Email) VALUES ('Aadress 1', '12345', 'andrei.reinus@gmail.com');
INSERT INTO Organisatsioon (Organisatsioon_ID, Registrikood, Nimi) VALUES (currval('osapool_osapool_id_seq'), 12301712, 'Oü Codecat');
INSERT INTO Klient (tootaja_id) VALUES (1);
INSERT INTO Ariklient VALUES (currval('klient_klient_id_seq'),currval('osapool_osapool_id_seq'));
INSERT INTO Projekt (klient_id, Projekti_seisund_ID, Nimi) VALUES (currval('klient_klient_id_seq'), 1, 'Suur projekt');
INSERT INTO Projekti_Liige (tootaja_id, Projekt_ID, tootaja_roll_id, Tunnihind, On_Aktiivne) VALUES (1, currval('projekt_projekt_id_seq'), 1, 12.33, true);
INSERT INTO Tooaeg (Projekti_Liige_ID, Tooaja_Seisund_ID, Algus, Lopp, Kirjeldus) VALUES (currval('projekti_liige_projekti_liige_id_seq'), 3, '2013-10-20 08:00:00', '2013-10-20 09:30:00', 'Kalamaja');
INSERT INTO Projekt (klient_id, Projekti_seisund_ID, Nimi) VALUES (currval('klient_klient_id_seq'), 1, 'Väike projekt');
INSERT INTO Projekti_Liige (tootaja_id, Projekt_ID, tootaja_roll_id, Tunnihind, On_Aktiivne) VALUES (1, currval('projekt_projekt_id_seq'), 1, 12.33, true);

---
INSERT INTO Osapool (Aadress, Telefon, Email) VALUES ('Aadress 1', '12345', 'andrei.reinus@gmail.com');
INSERT INTO Organisatsioon (Organisatsioon_ID, Registrikood, Nimi) VALUES (currval('osapool_osapool_id_seq'), 10421629, 'AS Eesti Energia');
INSERT INTO Klient (tootaja_id) VALUES (1);
INSERT INTO Ariklient VALUES (currval('klient_klient_id_seq'),currval('osapool_osapool_id_seq'));
INSERT INTO Projekt (klient_id, Projekti_seisund_ID, Nimi) VALUES (currval('klient_klient_id_seq'), 1, 'Suur projekt');
INSERT INTO Projekti_Liige (tootaja_id, Projekt_ID, tootaja_roll_id, Tunnihind, On_Aktiivne) VALUES (1, currval('projekt_projekt_id_seq'), 1, 12.33, true);
INSERT INTO Tooaeg (Projekti_Liige_ID, Tooaja_Seisund_ID, Algus, Lopp, Kirjeldus) VALUES (currval('projekti_liige_projekti_liige_id_seq'), 1, '2013-10-20 08:00:00', '2013-10-20 09:30:00', 'Kalamaja');
INSERT INTO Projekt (klient_id, Projekti_seisund_ID, Nimi) VALUES (currval('klient_klient_id_seq'), 1, 'Väike projekt');
INSERT INTO Projekti_Liige (tootaja_id, Projekt_ID, tootaja_roll_id, Tunnihind, On_Aktiivne) VALUES (1, currval('projekt_projekt_id_seq'), 1, 12.33, true);
