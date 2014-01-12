-- Kasutaja loomine
CREATE USER pmv_jurist WITH PASSWORD 'pmv_1234_jurist';

-- Võtta kõik õigused ära
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE CREATE, USAGE ON SCHEMA public FROM PUBLIC;
REVOKE USAGE ON LANGUAGE plpgsql FROM PUBLIC;

REVOKE EXECUTE ON FUNCTION
	fn_saabMuutaTooaeg (tooaeg.tooaeg_id%TYPE),
	fn_lisaTooaeg (tooaeg.projekti_liige_id%TYPE, tooaeg.algus%TYPE, tooaeg.lopp%TYPE, tooaeg.kirjeldus%TYPE),
	fn_uuendaTooaeg (tooaeg.tooaeg_id%TYPE, tooaeg.algus%TYPE, tooaeg.lopp%TYPE, tooaeg.kirjeldus%TYPE),
	fn_kinnitaTooaeg (tooaeg.tooaeg_id%TYPE),
	fn_kustutaTooaeg (tooaeg.tooaeg_id%TYPE),
	fn_valideeriKasutaja (Tootaja.Kasutajanimi%TYPE, Tootaja.Parool%TYPE),
	fn_kasutajaProjektid (int),
	fn_tooaegadeNimekiriInternal (user_id int, lubatud_seisundid int[]),
	fn_tooaegadeNimekiri (user_id int),
	fn_tooaegadeKoguNimekiri (user_id int)
FROM PUBLIC;

-- Peamised õigused 
GRANT CONNECT ON DATABASE k111881_pmv TO pmv_jurist;
GRANT USAGE ON SCHEMA public TO pmv_jurist;

-- Tabelid
GRANT SELECT ON
	tootaja, 
	isik,
	ariklient, 
	eraklient,
	organisatsioon,
	isik,
	osapool,
	projekt, 
	projekti_liige,
	tooaeg
TO pmv_jurist;

-- Funktsioonide õigused
GRANT EXECUTE ON FUNCTION
	fn_lisaTooaeg (tooaeg.projekti_liige_id%TYPE, tooaeg.algus%TYPE, tooaeg.lopp%TYPE, tooaeg.kirjeldus%TYPE),
	fn_uuendaTooaeg (tooaeg.tooaeg_id%TYPE, tooaeg.algus%TYPE, tooaeg.lopp%TYPE, tooaeg.kirjeldus%TYPE),
	fn_kinnitaTooaeg (tooaeg.tooaeg_id%TYPE),
	fn_kustutaTooaeg (tooaeg.tooaeg_id%TYPE),
	fn_valideeriKasutaja (Tootaja.Kasutajanimi%TYPE, Tootaja.Parool%TYPE),
	fn_kasutajaProjektid (int),
	fn_tooaegadeNimekiri (user_id int),
	fn_tooaegadeKoguNimekiri (user_id int)
TO pmv_jurist;

-- Vaated
GRANT SELECT ON
	kliendi_nimekiri
	, projekti_nimekiri
	, tootajate_nimekiri
TO pmv_jurist;