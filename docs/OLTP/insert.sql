-- kraje
INSERT INTO kraje (kod_kraju, nazwa) VALUES ('POL', 'Polska');
INSERT INTO kraje (kod_kraju, nazwa) VALUES ('GER', 'Niemcy');

-- style
INSERT INTO style (nazwa, opis) VALUES ('Witbier', XMLTYPE('<opis>Lekkie, orze�wiaj�ce, zm�tnione, wysokonasycone, bardzo jasne ale o przyjemnym owocowo-przyprawowym aromacie i niskiej goryczce. Du�y udzia� nies�odowanej pszenicy wp�ywa na znaczne zm�tnienie oraz nadaje piwu charakterystyczny smak. Barwa, poziom goryczki, zm�tnienie i wysycenie podobne jak w przypadku bawarskiego weissbiera. Aromat i smak owocowy i przyprawowy witbiera pochodz� bardziej z u�ytych dodatk�w ni� z procesu fermentacji. Charakter przyprawowy jest bardziej pieprzowy, ni� go�dzikowy, a owocowo�� ma bardziej cytrusowy ni� bananowo-gruszkowy charakter z jakim spotkamy si� w weissbierze.</opis>'));
INSERT INTO style (nazwa, opis) VALUES ('AIPA', XMLTYPE('<opis>Zdecydowanie chmielowe, nowofalowe, jasne, pe�ne, wytrawne, gorzkie ameryka�skie piwo g�rnej fermentacji. Ten opis odnosi si� do klasycznej, jasnej, czystej i zdominowanej przez chmiel interpretacji stylu, nazywanej czasem west coast IPA, dla odr�nienia od bardziej zbalansowanych IPA popularnych na wschodnim wybrze�u USA (east coast IPA) Piwa bardziej s�odowe, ciemniejsze lub o wyra�nym charakterze pochodz�cym z fermentacji opisane s� w innych pozycjach tego Kompendium.</opis>'));

-- browary
INSERT INTO browary (nazwa, data_zalozenia, kod_kraju) VALUES ('Pinta', TO_DATE('2011-05-07', 'YYYY-MM-DD'), 'POL');
INSERT INTO browary (nazwa, data_zalozenia, kod_kraju) VALUES ('Browar Kormoran', TO_DATE('1993-03-07', 'YYYY-MM-DD'), 'POL');

-- konta
INSERT INTO konta (nazwa, typ) VALUES ('Gerwazy', 'piwowar');
INSERT INTO konta (nazwa, typ) VALUES ('Talar', 'uzytkownik');


-- piwowarzy
INSERT INTO piwowarzy (id_konta, id_browaru) VALUES (1, 1);

-- miejscowosci
INSERT INTO miejscowosci (nazwa, kod_kraju) VALUES ('�osice', 'POL');
INSERT INTO miejscowosci (nazwa, kod_kraju) VALUES ('Rzeczyca', 'POL');

-- uzytkownicy
INSERT INTO uzytkownicy (id_konta, data_urodzenia, plec, numer_miejscowosci, kod_kraju) VALUES (2, TO_DATE('2002-07-05', 'YYYY-MM-DD'), 'M', 1, 'POL');


-- piwa
INSERT INTO piwa (numer_piwa, nazwa, opis, zawartosc_alkoholu, zawartosc_ekstraktu, goryczka, barwa, id_browaru, id_stylu)
VALUES (1, 'Atak Chmielu', 'PINTA Atak Chmielu to fantazyjnie nachmielone piwo w stylu American India Pale Ale.
Czerwono-miedziane, tre�ciwe, ze smakiem i aromatem cytrusowym, kwiatowym, �ywicznym, sosnowym i owocowym, pochodz�cym od ameryka�skiego chmielu. Fermentowane z u�yciem dro�d�y Safale US-05 w temp. 18-19�C.

Sk�ad: woda; s�ody: Weyermann�, Pale Ale, melanoidynowy, Carahell�, Carapils�; chmiele (USA): Citra, Simcoe, Cascade, Amarillo; dro�d�e: Safale US-05.', 6.1, 15.1, 60, 28, 1, 1);

-- recenzje
INSERT INTO recenzje (czas_recenzji, ocena_ogolna, smak, wyglad, aromat, id_uzytkownika, id_browaru, numer_piwa, komentarz)
VALUES (TO_TIMESTAMP('2019-03-08 15:57:11020', 'YYYY-MM-DD HH24:MI:SSFF3'), 8, 8, 8, 9, 1, 1, 1, 'Powr�t do klasyki po paru dobrych latach. Po wielu negatywnych opiniach kt�re s�ysza�em o tym piwie, �e si� zepsu�o, �e jest strasznie karmelowe, itp. Musz� stwierdzi�, �e spodziewa�em si� du�o gorszego piwa. Co prawda Atak nie jest tak dobry, jak za swoich najlepszych lat, ale jest to dalej fantastyczne piwo. Co do karmelu, to faktycznie jest go sporo, cho� znakomicie ��czy si� z mocn� i zalegaj�c� goryczk�. Karmel wspaniale tak�e ��czy si� w aromacie i smaku z nutami chmielowymi tworz�c \"zab�jcz�\" mieszank�. Pijalno�� bardzo dobra, piwo nie ma wad (cho� mo�e lekki diacetyl si� pojawia). Fantastyczna rzecz.');
