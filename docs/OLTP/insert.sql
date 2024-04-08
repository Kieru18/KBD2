-- kraje
INSERT INTO kraje (kod_kraju, nazwa) VALUES ('POL', 'Polska');
INSERT INTO kraje (kod_kraju, nazwa) VALUES ('GER', 'Niemcy');

-- style
INSERT INTO style (nazwa, opis) VALUES ('Witbier', XMLTYPE('<opis>Lekkie, orzeŸwiaj¹ce, zmêtnione, wysokonasycone, bardzo jasne ale o przyjemnym owocowo-przyprawowym aromacie i niskiej goryczce. Du¿y udzia³ nies³odowanej pszenicy wp³ywa na znaczne zmêtnienie oraz nadaje piwu charakterystyczny smak. Barwa, poziom goryczki, zmêtnienie i wysycenie podobne jak w przypadku bawarskiego weissbiera. Aromat i smak owocowy i przyprawowy witbiera pochodz¹ bardziej z u¿ytych dodatków ni¿ z procesu fermentacji. Charakter przyprawowy jest bardziej pieprzowy, ni¿ goŸdzikowy, a owocowoœæ ma bardziej cytrusowy ni¿ bananowo-gruszkowy charakter z jakim spotkamy siê w weissbierze.</opis>'));
INSERT INTO style (nazwa, opis) VALUES ('AIPA', XMLTYPE('<opis>Zdecydowanie chmielowe, nowofalowe, jasne, pe³ne, wytrawne, gorzkie amerykañskie piwo górnej fermentacji. Ten opis odnosi siê do klasycznej, jasnej, czystej i zdominowanej przez chmiel interpretacji stylu, nazywanej czasem west coast IPA, dla odró¿nienia od bardziej zbalansowanych IPA popularnych na wschodnim wybrze¿u USA (east coast IPA) Piwa bardziej s³odowe, ciemniejsze lub o wyraŸnym charakterze pochodz¹cym z fermentacji opisane s¹ w innych pozycjach tego Kompendium.</opis>'));

-- browary
INSERT INTO browary (nazwa, data_zalozenia, kod_kraju) VALUES ('Pinta', TO_DATE('2011-05-07', 'YYYY-MM-DD'), 'POL');
INSERT INTO browary (nazwa, data_zalozenia, kod_kraju) VALUES ('Browar Kormoran', TO_DATE('1993-03-07', 'YYYY-MM-DD'), 'POL');

-- konta
INSERT INTO konta (nazwa, typ) VALUES ('Gerwazy', 'piwowar');
INSERT INTO konta (nazwa, typ) VALUES ('Talar', 'uzytkownik');


-- piwowarzy
INSERT INTO piwowarzy (id_konta, id_browaru) VALUES (1, 1);

-- miejscowosci
INSERT INTO miejscowosci (nazwa, kod_kraju) VALUES ('£osice', 'POL');
INSERT INTO miejscowosci (nazwa, kod_kraju) VALUES ('Rzeczyca', 'POL');

-- uzytkownicy
INSERT INTO uzytkownicy (id_konta, data_urodzenia, plec, numer_miejscowosci, kod_kraju) VALUES (2, TO_DATE('2002-07-05', 'YYYY-MM-DD'), 'M', 1, 'POL');


-- piwa
INSERT INTO piwa (numer_piwa, nazwa, opis, zawartosc_alkoholu, zawartosc_ekstraktu, goryczka, barwa, id_browaru, id_stylu)
VALUES (1, 'Atak Chmielu', 'PINTA Atak Chmielu to fantazyjnie nachmielone piwo w stylu American India Pale Ale.
Czerwono-miedziane, treœciwe, ze smakiem i aromatem cytrusowym, kwiatowym, ¿ywicznym, sosnowym i owocowym, pochodz¹cym od amerykañskiego chmielu. Fermentowane z u¿yciem dro¿d¿y Safale US-05 w temp. 18-19°C.

Sk³ad: woda; s³ody: Weyermann®, Pale Ale, melanoidynowy, Carahell®, Carapils®; chmiele (USA): Citra, Simcoe, Cascade, Amarillo; dro¿d¿e: Safale US-05.', 6.1, 15.1, 60, 28, 1, 1);

-- recenzje
INSERT INTO recenzje (czas_recenzji, ocena_ogolna, smak, wyglad, aromat, id_uzytkownika, id_browaru, numer_piwa, komentarz)
VALUES (TO_TIMESTAMP('2019-03-08 15:57:11020', 'YYYY-MM-DD HH24:MI:SSFF3'), 8, 8, 8, 9, 1, 1, 1, 'Powrót do klasyki po paru dobrych latach. Po wielu negatywnych opiniach które s³ysza³em o tym piwie, ¿e siê zepsu³o, ¿e jest strasznie karmelowe, itp. Muszê stwierdziæ, ¿e spodziewa³em siê du¿o gorszego piwa. Co prawda Atak nie jest tak dobry, jak za swoich najlepszych lat, ale jest to dalej fantastyczne piwo. Co do karmelu, to faktycznie jest go sporo, choæ znakomicie ³¹czy siê z mocn¹ i zalegaj¹c¹ goryczk¹. Karmel wspaniale tak¿e ³¹czy siê w aromacie i smaku z nutami chmielowymi tworz¹c \"zabójcz¹\" mieszankê. Pijalnoœæ bardzo dobra, piwo nie ma wad (choæ mo¿e lekki diacetyl siê pojawia). Fantastyczna rzecz.');
