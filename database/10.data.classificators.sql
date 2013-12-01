INSERT INTO Tootaja_Roll VALUES
	(1, 'Jurist', 'Tavatöötaja'),
	(2, 'Kliendihaldur', 'Inimene, kes haldab kliente'),
	(3, 'Raamatupidaja', 'Inimene, kes tegeleb raamatupidamisega');

INSERT INTO Tooaja_Seisund VALUES
	(1, 'Avatud', 'Tööaeg on avatud'),
	(2, 'Sisestatud', 'Tööaeg on saadetud kinnitamiseks'),
	(3, 'Kinnitatud', 'Tööaeg on valmis arve koostamiseks'),
	(4, 'Arvestatud', 'Tööaja kohta on koostatud arve'),
	(5, 'Parandamiseks', 'Tööaeg on saadetud tagasi parandamiseks'),
	(6, 'Arhiveeritud', 'Tööaeg on arhiveeritud');

INSERT INTO Projekti_Seisund VALUES
	(1, 'Avatud', 'Projekt avatud'),
	(2, 'Suletud', 'Projekt suletud');