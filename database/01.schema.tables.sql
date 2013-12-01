CREATE TABLE osapool
(
	osapool_id serial NOT NULL,
	aadress d_address,
	telefon d_telefon,
	email d_e_mail,

	CONSTRAINT PK_Osapool PRIMARY KEY (osapool_id)
);

CREATE TABLE organisatsioon
(
	organisatsioon_id integer NOT NULL,
	registrikood d_registrikood,
	nimi d_nimi,

	CONSTRAINT PK_Organisatsioon PRIMARY KEY (organisatsioon_id),
	CONSTRAINT AK_Registrikood UNIQUE (registrikood),
	CONSTRAINT FK_Organisatsioon__Osapool
		FOREIGN KEY (organisatsioon_ID)
		REFERENCES osapool (osapool_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE isik
(
	isik_id integer NOT NULL,
	eesnimi d_nimi,
	perekonnanimi d_nimi,

	CONSTRAINT PK_Isik PRIMARY KEY (isik_id),
	CONSTRAINT FK_Isik__Osapool
		FOREIGN KEY (isik_id)
		REFERENCES osapool (osapool_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tootaja
(
	tootaja_id integer NOT NULL,

	kasutajanimi varchar(50) NOT NULL,
	parool varchar(50) NOT NULL,

	CONSTRAINT PK_Tootaja PRIMARY KEY (tootaja_id),
	CONSTRAINT FK_Tootaja__Isik
		FOREIGN KEY (tootaja_id)
		REFERENCES Isik (isik_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE klient
(
	klient_id serial NOT NULL,
	tootaja_id integer NOT NULL,

	CONSTRAINT PK_Klient PRIMARY KEY (klient_id),
	CONSTRAINT FK_Klient__Tootaja
		FOREIGN KEY (tootaja_id)
		REFERENCES Tootaja (tootaja_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE ariklient
(
	klient_id integer NOT NULL,
	organisatsioon_ID integer NOT NULL,

	CONSTRAINT PK_Ariklient PRIMARY KEY (klient_id),
	CONSTRAINT UQ_Organisatsioon UNIQUE (organisatsioon_id),
	CONSTRAINT FK_Ariklient__Klient
		FOREIGN KEY (klient_id)
		REFERENCES klient
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Ariklient__Organisatioon
		FOREIGN KEY (organisatsioon_id)
		REFERENCES organisatsioon
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE eraklient
(
	klient_id integer NOT NULL,
	isik_id integer NOT NULL,

	CONSTRAINT PK_Eraklient PRIMARY KEY (klient_id),
	CONSTRAINT UQ_Isik UNIQUE (isik_id),
	CONSTRAINT FK_Eraklient__Klient
		FOREIGN KEY (klient_id)
		REFERENCES Klient
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Eraklient__Isik
		FOREIGN KEY (isik_id)
		REFERENCES Isik
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE projekti_seisund
(
	projekti_seisund_id d_klassifikaatori_id,
	nimetus d_nimetus,
	kirjeldus d_kirjeldus,

	CONSTRAINT PK_Projekti_Seisund PRIMARY KEY (projekti_seisund_id),
	CONSTRAINT UNQ_Projekti_Seisund_Nimetus UNIQUE (nimetus)
);


CREATE TABLE tooaja_seisund
(
	tooaja_seisund_id d_klassifikaatori_id,
	nimetus d_nimetus,
	kirjeldus d_kirjeldus,

	CONSTRAINT PK_Tooaja_Seisund PRIMARY KEY (tooaja_seisund_id),
	CONSTRAINT UNQ_Tooaja_Seisund_Nimetus UNIQUE (nimetus)
);


CREATE TABLE tootaja_roll
(
	tootaja_roll_id d_klassifikaatori_id,
	nimetus d_nimetus,
	kirjeldus d_kirjeldus,

	CONSTRAINT PK_Tootaja_Roll PRIMARY KEY (tootaja_roll_id),
	CONSTRAINT UNQ_Tootaja_Roll_Nimetus UNIQUE (nimetus)
);

CREATE TABLE Projekt
(
	projekt_id serial NOT NULL,
	klient_id integer NOT NULL,
	projekti_seisund_id d_klassifikaatori_id DEFAULT 1, -- Avatud
	nimi d_nimi,

	CONSTRAINT PK_Projekt PRIMARY KEY (projekt_id),
	CONSTRAINT UNQ_Kliendi_piires_projekti_nimi_unikaalne UNIQUE (klient_id, nimi),
	CONSTRAINT FK_Projekt__Klient
		FOREIGN KEY (klient_id)
		REFERENCES klient
  		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Projekt__Projekti_Seisund
		FOREIGN KEY (projekti_seisund_id)
		REFERENCES projekti_seisund
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Projekti_Liige
(
	projekti_liige_id serial NOT NULL,
	tootaja_id integer NOT NULL,
	projekt_id integer NOT NULL,
	tootaja_roll_id d_klassifikaatori_id DEFAULT 1, -- Jurist
	tunnihind d_tunnihind,
	on_aktiivne boolean NOT NULL DEFAULT true,

	CONSTRAINT PK_Projekti_Liige PRIMARY KEY (projekti_liige_id),
	CONSTRAINT chk_Projekti_Liige__Tunnihind_on_pos_arv CHECK (tunnihind > 0),
	CONSTRAINT FK_Projekti_Liige__Projekt
		FOREIGN KEY (projekt_id)
		REFERENCES projekt
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Projekti_Liige__Tootaja
		FOREIGN KEY (tootaja_id)
		REFERENCES tootaja
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Projekti_Liige__Tootaja_Roll
		FOREIGN KEY (tootaja_roll_id)
		REFERENCES tootaja_roll
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tooaeg
(
	tooaeg_id serial not null,
	projekti_liige_id integer not null,
	tooaja_seisund_id d_klassifikaatori_id DEFAULT 1, -- Avatud
	algus timestamp without time zone not null,
	lopp timestamp without time zone not null,
	kirjeldus varchar(1000) not null,

	CONSTRAINT PK_Tooaeg PRIMARY KEY (tooaeg_id),
	CONSTRAINT chk_Tooaeg__Algus_enne_loppu CHECK (Algus < Lopp),
	CONSTRAINT chk_Tooaeg__Lopp_tulevikus CHECK (Lopp <= now()),
	CONSTRAINT chk_Tooaeg__Kirjeldus_ei_koosne_tyhikutest CHECK (Kirjeldus!~'^[[:space:]]*$'),
	CONSTRAINT FK_Tooaeg__Projekti_Liige
		FOREIGN KEY (Projekti_Liige_ID)
		REFERENCES Projekti_Liige
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_Tooaeg__Tooaja_Seisund
		FOREIGN KEY (Tooaja_Seisund_ID)
		REFERENCES Tooaja_Seisund
		ON UPDATE CASCADE ON DELETE CASCADE
);