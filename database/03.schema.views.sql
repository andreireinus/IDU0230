CREATE OR REPLACE VIEW kliendi_nimekiri WITH (security_barrier) AS SELECT
	k.klient_id
	, CASE WHEN org.organisatsioon_id IS NULL THEN 'Eraklient' ELSE 'Äriklient' END AS kliendi_liik
	, CASE WHEN e_isik.isik_id IS NULL
		THEN org.nimi
		ELSE e_isik.eesnimi || ' ' || e_isik.perekonnanimi
		END AS kliendi_nimi
	, k.tootaja_id AS kliendihalduri_id
	, t_isik.eesnimi || ' ' || t_isik.perekonnanimi AS kliendihalduri_nimi
FROM
	klient k
	JOIN tootaja t ON (k.tootaja_id = t.tootaja_id)
	JOIN isik t_isik ON (t.tootaja_id = t_isik.isik_id)

	LEFT JOIN ariklient ak ON (ak.klient_id = k.klient_id)
	LEFT JOIN organisatsioon org ON (org.organisatsioon_id = ak.organisatsioon_id)

	LEFT JOIN eraklient ek ON (ek.klient_id = k.klient_id)
	LEFT JOIN isik e_isik ON (e_isik.isik_id = ek.isik_id)

ORDER BY kliendi_nimi;

CREATE OR REPLACE VIEW projekti_nimekiri WITH (security_barrier) AS
SELECT
	p.projekt_id
	, p.projekti_seisund_id
	, ps.nimetus AS projekti_seisund
	, p.nimi AS projekti_nimi
	, k.klient_id
	, k.kliendi_nimi
	, k.kliendihalduri_nimi
FROM
	projekt p
	JOIN kliendi_nimekiri k ON (p.klient_id = k.klient_id)
	JOIN projekti_seisund ps ON (ps.projekti_seisund_id = p.projekti_seisund_id)
ORDER BY projekti_nimi;

CREATE OR REPLACE VIEW tootajate_nimekiri WITH (security_barrier) AS
select
  t.tootaja_id
  , i.eesnimi || ' ' || i.perekonnanimi AS tootaja_nimi
from
  tootaja t
  join isik i on (t.tootaja_id = i.isik_id)
ORDER BY tootaja_nimi;
