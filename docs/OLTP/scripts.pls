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

CREATE OR REPLACE FUNCTION color_description(barwa_ebc IN NUMBER) RETURN VARCHAR2 IS
/*
Funkcja konwertuj¹ca barwê piwa mierzon¹ w EBC (European Brewery Convention) na zrozumia³y przez u¿ytkownika kolor.
@TODO - zmienic na polskie kolory, plus lepiej podzieliæ skalê kolorów bo nie jest najlepsza
*/
BEGIN
    RETURN CASE
        WHEN barwa_ebc >= 0 THEN 'Very light'
        WHEN barwa_ebc >= 4 THEN 'Light'
        WHEN barwa_ebc >= 6 THEN 'Pale gold'
        WHEN barwa_ebc >= 8 THEN 'Straw'
        WHEN barwa_ebc >= 12 THEN 'Medium gold'
        WHEN barwa_ebc >= 16 THEN 'Deep gold'
        WHEN barwa_ebc >= 20 THEN 'Amber'
        WHEN barwa_ebc >= 26 THEN 'Deep amber'
        WHEN barwa_ebc >= 33 THEN 'Copper'
        WHEN barwa_ebc >= 39 THEN 'Deep copper'
        WHEN barwa_ebc >= 47 THEN 'Brown'
        WHEN barwa_ebc >= 57 THEN 'Dark brown'
        WHEN barwa_ebc >= 69 THEN 'Very dark brown'
        WHEN barwa_ebc >= 79 THEN 'Black'
        ELSE 'Unknown'
    END;
END;
/


