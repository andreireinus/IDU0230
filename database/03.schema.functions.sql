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
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_uuendaTooaeg (
	tooaeg.tooaeg_id%TYPE
	, tooaeg.algus%TYPE
	, tooaeg.lopp%TYPE
	, tooaeg.kirjeldus%TYPE
) RETURNS boolean
AS $$
BEGIN
	UPDATE 
		tooaeg
	SET
		algus = $2
		, lopp = $3
		, kirjeldus = $4
	WHERE
		tooaeg_id = $1;
	return true;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_kustutaTooaeg (
	tooaeg.tooaeg_id%TYPE
) RETURNS boolean
AS $$
BEGIN
	DELETE FROM
		tooaeg
	WHERE
		tooaeg.tooaeg_id = $1;
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
$$ LANGUAGE SQL;

-- $1 tooaeg_id
-- $2 user_id
CREATE OR REPLACE FUNCTION fn_kasutajaTooaeg(int, int)
RETURNS Tooaeg AS $$
	select 
		t.* 
	from 
		Tooaeg t 
		JOIN Projekti_Liige pl ON (pl.Projekti_Liige_ID = t.Projekti_Liige_ID)
	WHERE 
		t.Tooaeg_ID = $1
		AND pl.tootaja_id = $2;
$$ LANGUAGE SQL;