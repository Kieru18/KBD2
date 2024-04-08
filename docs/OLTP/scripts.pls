CREATE OR REPLACE TRIGGER check_if_legal_age
BEFORE INSERT ON uzytkownicy
FOR EACH ROW
/* 
Wyzwalacz sprawdzaj¹cy, czy dodawny u¿ytkownik jest pe³noletni.
Ze wglêdu na tematykê systemu, niepe³noletni u¿ytkownicy nie mog¹ z niej korzystaæ.
@TODO - sprawdzanie co do dnia
*/
DECLARE
    v_years NUMBER;
BEGIN
    v_years := TRUNC(MONTHS_BETWEEN(SYSDATE, :NEW.data_urodzenia) / 12);

    IF v_years < 18 THEN
        RAISE_APPLICATION_ERROR(-20001, 'User must be at least 18 years old.');
    END IF;
END;
/

CREATE OR REPLACE FUNCTION color_description(piwo_barwa IN NUMBER) RETURN VARCHAR2 IS
/*
Funkcja konwertuj¹ca barwê piwa mierzon¹ w EBC (European Brewery Convention) na zrozumia³y przez u¿ytkownika kolor.
@TODO - zmienic na polskie kolory, plus lepiej podzieliæ skalê kolorów bo nie jest najlepsza
*/
BEGIN
    RETURN CASE
        WHEN piwo_barwa >= 0 THEN 'Very light'
        WHEN piwo_barwa >= 4 THEN 'Light'
        WHEN piwo_barwa >= 6 THEN 'Pale gold'
        WHEN piwo_barwa >= 8 THEN 'Straw'
        WHEN piwo_barwa >= 12 THEN 'Medium gold'
        WHEN piwo_barwa >= 16 THEN 'Deep gold'
        WHEN piwo_barwa >= 20 THEN 'Amber'
        WHEN piwo_barwa >= 26 THEN 'Deep amber'
        WHEN piwo_barwa >= 33 THEN 'Copper'
        WHEN piwo_barwa >= 39 THEN 'Deep copper'
        WHEN piwo_barwa >= 47 THEN 'Brown'
        WHEN piwo_barwa >= 57 THEN 'Dark brown'
        WHEN piwo_barwa >= 69 THEN 'Very dark brown'
        WHEN piwo_barwa >= 79 THEN 'Black'
        ELSE 'Unknown'
    END;
END;
/


