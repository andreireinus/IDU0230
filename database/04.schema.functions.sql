SET client_min_messages TO WARNING; 
SET CLIENT_ENCODING TO 'UTF8';
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;

CREATE OR REPLACE FUNCTION sha1(text) returns text AS $$
	SELECT encode(digest($1::bytea, 'sha1'), 'hex')
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION fn_saabMuutaTooaeg (
	tooaeg.tooaeg_id%TYPE
) RETURNS boolean
AS $$
DECLARE
	seisund int;
BEGIN
	SELECT tooaeg.tooaja_seisund_id INTO seisund FROM tooaeg WHERE tooaeg_id = $1;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Tooaega ei leitud!';
 	END IF;

 	IF seisund <> 1 AND seisund <> 5 THEN
		RAISE EXCEPTION 'Ainult Avatud ja Parandamiseks seisundis tööaegu saab muuta/kustutada!';
 	END IF;
	
	RETURN true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION fn_lisaTooaeg (
	tooaeg.projekti_liige_id%TYPE
	, tooaeg.algus%TYPE
	, tooaeg.lopp%TYPE
	, tooaeg.kirjeldus%TYPE
) RETURNS tooaeg.tooaeg_id%TYPE
AS $$
BEGIN
	INSERT INTO tooaeg
		(projekti_liige_id, algus, lopp,kirjeldus)
    VALUES 
		($1, $2, $3, $4);
	
	RETURN currval('tooaeg_tooaeg_id_seq');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION fn_uuendaTooaeg (
	tooaeg.tooaeg_id%TYPE
	, tooaeg.algus%TYPE
	, tooaeg.lopp%TYPE
	, tooaeg.kirjeldus%TYPE
) RETURNS void
AS $$
BEGIN
	PERFORM fn_saabMuutaTooaeg($1);
	UPDATE 
		tooaeg
	SET
		algus = $2
		, lopp = $3
		, kirjeldus = $4
	WHERE
		tooaeg_id = $1;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION fn_kinnitaTooaeg (
	tooaeg.tooaeg_id%TYPE
) RETURNS void
AS $$
BEGIN
	PERFORM fn_saabMuutaTooaeg($1);
	
	UPDATE tooaeg SET tooaja_seisund_id = 2 WHERE tooaeg_id = $1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_kustutaTooaeg (
	tooaeg.tooaeg_id%TYPE
) RETURNS boolean
AS $$
BEGIN
	PERFORM fn_saabMuutaTooaeg($1);
	
	DELETE FROM tooaeg
 	WHERE tooaeg.tooaeg_id = $1;
 	
	RETURN true;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_valideeriKasutaja (
	Tootaja.Kasutajanimi%TYPE
	, Tootaja.Parool%TYPE)
RETURNS Tootaja.Tootaja_id%TYPE 
AS $$
DECLARE
	nr int;
BEGIN
	SELECT t.Tootaja_id INTO nr FROM Tootaja t WHERE t.Kasutajanimi = $1 AND t.Parool = $2 LIMIT 1;

	IF nr IS NULL THEN
		nr := -1;
	END IF;
	
	RETURN nr;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_kasutajaProjektid (int)
RETURNS TABLE(
		projekti_liige_id projekti_liige.projekti_liige_id%TYPE
		, projekti_nimi projekti_nimekiri.projekti_nimi%TYPE
		, klient_id projekti_nimekiri.klient_id%TYPE
		, kliendi_nimi projekti_nimekiri.kliendi_nimi%TYPE
) AS $$
	SELECT
		pl.projekti_liige_id,
		p.projekti_nimi,
		p.klient_id,
		p.kliendi_nimi
	FROM
		Projekti_Liige pl
		JOIN projekti_nimekiri p ON (p.projekt_id = pl.Projekt_ID)
	WHERE
		pl.Tootaja_id = $1
	ORDER BY
		p.kliendi_nimi, p.projekti_nimi
$$ LANGUAGE SQL;


CREATE OR REPLACE FUNCTION fn_tooaegadeNimekiriInternal (user_id int, lubatud_seisundid int[])
RETURNS TABLE(
		tooaeg_id Tooaeg.Tooaeg_Id%TYPE
		, seisund_nimetus Tooaja_Seisund.Nimetus%TYPE
		, algus Tooaeg.Algus%TYPE
		, lopp Tooaeg.Lopp%TYPE
		, kirjeldus Tooaeg.Kirjeldus%TYPE
		, projekti_nimi projekti_nimekiri.projekti_nimi%TYPE
		, kliendi_nimi projekti_nimekiri.kliendi_nimi%TYPE
) AS $$
	SELECT
		t.Tooaeg_Id,
		ts.Nimetus,
		t.Algus,
		t.Lopp,
		t.Kirjeldus,
		p.projekti_nimi,
		p.kliendi_nimi
	FROM
		Tooaeg t
		JOIN Projekti_Liige pl ON (pl.Projekti_Liige_ID = t.Projekti_Liige_ID)
		JOIN projekti_nimekiri p ON (p.projekt_id = pl.Projekt_ID)
		JOIN Tooaja_Seisund ts ON (ts.Tooaja_Seisund_ID = t.Tooaja_Seisund_ID)
	WHERE
		pl.tootaja_id = $1
		AND ts.tooaja_seisund_id = ANY(lubatud_seisundid);
$$ LANGUAGE SQL;




CREATE OR REPLACE FUNCTION fn_tooaegadeNimekiri (user_id int)
RETURNS TABLE(
		tooaeg_id Tooaeg.Tooaeg_Id%TYPE
		, seisund_nimetus Tooaja_Seisund.Nimetus%TYPE
		, algus Tooaeg.Algus%TYPE
		, lopp Tooaeg.Lopp%TYPE
		, kirjeldus Tooaeg.Kirjeldus%TYPE
		, projekti_nimi projekti_nimekiri.projekti_nimi%TYPE
		, kliendi_nimi projekti_nimekiri.kliendi_nimi%TYPE
) AS $$
	SELECT * FROM fn_tooaegadeNimekiriInternal(user_id, '{1,5}');
$$ LANGUAGE SQL;


CREATE OR REPLACE FUNCTION fn_tooaegadeKoguNimekiri (user_id int)
RETURNS TABLE(
		tooaeg_id Tooaeg.Tooaeg_Id%TYPE
		, seisund_nimetus Tooaja_Seisund.Nimetus%TYPE
		, algus Tooaeg.Algus%TYPE
		, lopp Tooaeg.Lopp%TYPE
		, kirjeldus Tooaeg.Kirjeldus%TYPE
		, projekti_nimi projekti_nimekiri.projekti_nimi%TYPE
		, kliendi_nimi projekti_nimekiri.kliendi_nimi%TYPE
) AS $$
	SELECT * FROM fn_tooaegadeNimekiriInternal(user_id, '{1,2,3,4,5}');
$$ LANGUAGE SQL;
