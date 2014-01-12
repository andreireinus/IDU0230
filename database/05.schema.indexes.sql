-- Foreign-Key indeksid

CREATE INDEX IDX__klient__tootaja_id ON klient(tootaja_id);

CREATE INDEX IDX__projekt__klient_id ON projekt(klient_id);
CREATE INDEX IDX__projekt__projekti_seisund_id ON projekt(projekti_seisund_id);

CREATE INDEX IDX__Projekti_Liige__tootaja_id ON Projekti_Liige(tootaja_id);
CREATE INDEX IDX__Projekti_Liige__projekt_id ON Projekti_Liige(projekt_id);
CREATE INDEX IDX__Projekti_Liige__tootaja_roll_id ON Projekti_Liige(tootaja_roll_id);

CREATE INDEX IDX__tooaeg__projekti_liige_id ON tooaeg(projekti_liige_id);
CREATE INDEX IDX__tooaeg__tooaja_seisund_id ON tooaeg(tooaja_seisund_id);