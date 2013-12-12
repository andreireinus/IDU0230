--- ------------------------------------------------ ---
--- Domeenide kontrolli jaoks vajalikud funktsioonid ---
--- ------------------------------------------------ ---
CREATE OR REPLACE FUNCTION fn_checkKood(kood integer) RETURNS boolean AS $$
DECLARE
	mods1 int[];
	mods2 int[];
	digits int[];
	expectedSum int;
	actualSum int;
BEGIN
	mods1 := ARRAY[ 1, 2, 3, 4, 5, 6, 7 ];
	mods2 := ARRAY[ 3, 4, 5, 6, 7, 8, 9 ];

	SELECT * INTO digits, expectedSum FROM fn_intToDigits(kood);
	actualSum := fn_calculateCheckSum(digits, mods1);

	IF actualSum = 10 THEN
		actualSum := fn_calculateCheckSum(digits, mods2);
	END IF;

	IF actualSum = 10 THEN
		actualSum := 0;
	END IF;

	RETURN (actualSum = expectedSum);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_intToDigits(kood integer, OUT arr integer[], OUT checkSum integer) AS $$
DECLARE
	i integer;
	inText text;
BEGIN
	inText := kood :: text;
	i := 1;

	WHILE i <= LENGTH(inText)  LOOP
		IF (i = LENGTH(inText)) THEN
			checkSum := substring(inText from i for 1) :: integer;
		ELSE
			arr[i-1] := substring(inText from i for 1) :: integer;
		END IF;
		i := i + 1;
	END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_calculateCheckSum(nums integer[], mods integer[]) RETURNS integer AS $$
DECLARE
	i integer;
	result integer;
BEGIN
	result := 0;
	FOR i IN 0..6 LOOP
		result := result + (nums[i] * mods[i + 1]);
	END LOOP;
	result := result % 11;

	RETURN result;
END;
$$ LANGUAGE plpgsql;

--- ---------- ---
---  Domeenid  ---
--- -=-------- ---
CREATE DOMAIN d_klassifikaatori_id AS smallint
  NOT NULL
  CONSTRAINT Id_peab_olema_nullist_suurem CHECK (VALUE > 0);

CREATE DOMAIN d_address AS character varying(100)
  NOT NULL
  CONSTRAINT Aadress_ei_tohi_olla_tyhi CHECK (LENGTH(TRIM(VALUE)) > 0);

CREATE DOMAIN d_tunnihind AS decimal(8,2)
  NOT NULL
  CONSTRAINT Hind_peab_olema_positiivne_arv CHECK(VALUE > 0);

CREATE DOMAIN d_telefon AS character varying(20)
  NOT NULL
  CONSTRAINT Telefon_formaadi_kontroll CHECK (VALUE ~ '^[+]?[[:digit:]]+$')
  CONSTRAINT Telefon_ei_tohi_olla_tyhi CHECK (LENGTH(TRIM(VALUE)) > 0);

CREATE DOMAIN d_e_mail AS character varying(30)
  NOT NULL
  CONSTRAINT Email_formaadi_kontroll CHECK (VALUE LIKE '%@%\.%');

CREATE DOMAIN d_registrikood AS integer
  NOT NULL
  CONSTRAINT Registrikoodi_kontroll CHECK (fn_checkKood(VALUE))
  CONSTRAINT Registrikood_peab_langema_vahemiku CHECK (VALUE >= 10000000 AND VALUE <= 99999999);

CREATE DOMAIN d_nimi AS character varying(50)
  NOT NULL
  CONSTRAINT Nimi_ei_tohi_olla_tyhi CHECK (LENGTH(TRIM(VALUE)) > 0);

CREATE DOMAIN d_nimetus AS character varying(30)
  NOT NULL
  CONSTRAINT Nimetus_ei_tohi_olla_tyhi CHECK (LENGTH(TRIM(VALUE)) > 0);

CREATE DOMAIN d_kirjeldus AS character varying(100)
  NOT NULL
  CONSTRAINT Kirjeldus_ei_tohi_olla_tyhi CHECK (LENGTH(TRIM(VALUE)) > 0);