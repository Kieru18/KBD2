CREATE TABLE cechy_recenzentow (
    id_cechy_recenzenta NUMBER(4) NOT NULL,
    rok_urodzenia       NUMBER(4),
    plec                CHAR(1 CHAR),
    numer_miejscowosci  NUMBER(4),
    nazwa_miejscowosci  VARCHAR2(35),
    kod_kraju           VARCHAR2(3),
    nazwa_kraju         VARCHAR2(56)
) TABLESPACE KBD2_3
LOGGING;

ALTER TABLE cechy_recenzentow ADD CONSTRAINT konto_pk PRIMARY KEY ( id_cechy_recenzenta );

CREATE TABLE dni (
    data_recenzji  DATE NOT NULL,
    dzien_tygodnia NUMBER(1) NOT NULL,
    miesiac        NUMBER(2) NOT NULL,
    pora_roku      NUMBER(1) NOT NULL,
    rok            NUMBER(4) NOT NULL
) TABLESPACE KBD2_3
LOGGING;


ALTER TABLE dni ADD CONSTRAINT dni_pk PRIMARY KEY ( data_recenzji );

CREATE TABLE piwa (
    id_piwa             NUMBER(4) NOT NULL,
    nazwa               VARCHAR2(35 CHAR) NOT NULL,
    id_browaru          NUMBER(4) NOT NULL,
    nazwa_browaru       VARCHAR2(30) NOT NULL,
    kod_kraju           VARCHAR2(3) NOT NULL,
    nazwa_kraju         VARCHAR2(56) NOT NULL,
    id_stylu            NUMBER(4) NOT NULL,
    nazwa_stylu         VARCHAR2(40) NOT NULL,
    zawartosc_alkoholu  NUMBER(3, 1) NOT NULL,
    zawartosc_ekstraktu NUMBER(3, 1) NOT NULL,
    goryczka            NUMBER(4) NOT NULL,
    barwa               NUMBER(2) NOT NULL
) TABLESPACE KBD2_3
LOGGING;

COMMENT ON COLUMN dni.data_recenzji IS 'Data recenzji bez czasu';
COMMENT ON COLUMN dni.dzien_tygodnia IS 'Dzień tygodnia (1-7), gdzie 1 to poniedziałek, a 7 to niedziela';
COMMENT ON COLUMN dni.miesiac IS 'Miesiąc (1-12), gdzie 1 to styczeń, a 12 to grudzień';
COMMENT ON COLUMN dni.pora_roku IS 'Pora roku (1-4), gdzie 1 to wiosna, 2 lato, 3 jesień, 4 zima';
COMMENT ON COLUMN dni.rok IS 'Rok w formacie czterocyfrowym';

ALTER TABLE piwa ADD CONSTRAINT piwa_pk PRIMARY KEY ( id_piwa );

CREATE TABLE recenzje (
    data_i_czas_recenzji DATE NOT NULL,
    ocena_ogolna NUMBER(2) NOT NULL,
    smak NUMBER(2) NOT NULL,
    wyglad NUMBER(2) NOT NULL,
    aromat NUMBER(2) NOT NULL,
    id_piwa NUMBER(4) NOT NULL,
    id_cechy_recenzenta NUMBER(4) NOT NULL,
    data_recenzji DATE GENERATED ALWAYS AS (TRUNC(data_i_czas_recenzji)) VIRTUAL NOT NULL,
    czas_recenzji VARCHAR2(8) GENERATED ALWAYS AS (TO_CHAR(data_i_czas_recenzji, 'HH24:MI:SS')) VIRTUAL NOT NULL
)
PARTITION BY RANGE (data_recenzji)
INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
(PARTITION partycja_1 VALUES LESS THAN (TO_DATE('2024-01-01', 'YYYY-MM-DD')))
TABLESPACE KBD2_4
LOGGING;

COMMENT ON COLUMN recenzje.data_recenzji IS
    'Kolumna wirtualna zawierająca informacje o dacie, bez czasu. 
Stworzona azeby być kluczem obcym do tabeli dni.';

COMMENT ON COLUMN recenzje.czas_recenzji IS
    'Kolumna wirtualna zawierająca informacje o godzinie, bez daty.
';

ALTER TABLE recenzje
    ADD CONSTRAINT recenzje_pk PRIMARY KEY ( id_piwa,
                                             id_cechy_recenzenta,
                                             czas_recenzji,
                                             data_recenzji );

ALTER TABLE recenzje
    ADD CONSTRAINT recenzje_cechy_recenzentow_fk FOREIGN KEY ( id_cechy_recenzenta )
        REFERENCES cechy_recenzentow ( id_cechy_recenzenta )
    DISABLE NOVALIDATE ;

ALTER TABLE recenzje
    ADD CONSTRAINT recenzje_dni_fk FOREIGN KEY ( data_recenzji )
        REFERENCES dni ( data_recenzji )
    DISABLE NOVALIDATE ;

ALTER TABLE recenzje
    ADD CONSTRAINT recenzje_piwo_fk FOREIGN KEY ( id_piwa )
        REFERENCES piwa ( id_piwa )
    DISABLE NOVALIDATE ;


CREATE BITMAP INDEX recenzje_konta_FK_I ON recenzje (id_cechy_recenzenta) LOCAL TABLESPACE KBD2_3;
CREATE BITMAP INDEX recenzje_piwa_FK_I ON recenzje (id_piwa) LOCAL TABLESPACE KBD2_3;

CREATE BITMAP INDEX recenzje_dzien_tygodnia_JI ON recenzje (dni.dzien_tygodnia)
FROM recenzje, dni
WHERE recenzje.data_recenzji = dni.data_recenzji LOCAL TABLESPACE KBD2_4;

CREATE BITMAP INDEX recenzje_miesiac_JI ON recenzje (dni.miesiac)
FROM recenzje, dni
WHERE recenzje.data_recenzji = dni.data_recenzji LOCAL TABLESPACE KBD2_4;

CREATE BITMAP INDEX recenzje_pora_roku_JI ON recenzje (dni.pora_roku)
FROM recenzje, dni
WHERE recenzje.data_recenzji = dni.data_recenzji LOCAL TABLESPACE KBD2_4;

CREATE BITMAP INDEX recenzje_rok_JI ON recenzje (dni.rok)
FROM recenzje, dni
WHERE recenzje.data_recenzji = dni.data_recenzji LOCAL TABLESPACE KBD2_4;

CREATE BITMAP INDEX recenzje_plec_JI ON recenzje (cechy_recenzentow.plec)
FROM recenzje, cechy_recenzentow
WHERE recenzje.id_cechy_recenzenta = cechy_recenzentow.id_cechy_recenzenta LOCAL TABLESPACE KBD2_4;

CREATE BITMAP INDEX recenzje_nazwa_browaru_JI ON recenzje (piwa.nazwa_browaru)
FROM recenzje, piwa
WHERE recenzje.id_piwa = piwa.id_piwa LOCAL TABLESPACE KBD2_4;