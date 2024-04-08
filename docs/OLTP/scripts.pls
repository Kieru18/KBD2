CREATE OR REPLACE TRIGGER check_if_legal_age
BEFORE INSERT ON uzytkownicy
FOR EACH ROW
/* 
Wyzwalacz sprawdzający, czy dodawny użytkownik jest pełnoletni.
Ze wględu na tematykę systemu, niepełnoletni użytkownicy nie mogą z niej korzystać.
*/
DECLARE
    v_legal_age DATE;
BEGIN
    v_legal_age := ADD_MONTHS(:NEW.data_urodzenia, 12*18);

    IF v_legal_age >= TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20001, 'User must be at least 18 years old.');
    END IF;
END;
/


CREATE OR REPLACE FUNCTION color_description(barwa_ebc IN NUMBER) RETURN VARCHAR2 IS
/*
Funkcja konwertująca barwę piwa mierzoną w EBC (European Brewery Convention) na zrozumiały przez użytkownika kolor.
*/
BEGIN
    RETURN CASE
        WHEN barwa_ebc >= 0 THEN 'Słomokowy'
        WHEN barwa_ebc >= 4 THEN 'Jasny zółty'
        WHEN barwa_ebc >= 6 THEN 'Żółty'
        WHEN barwa_ebc >= 8 THEN 'Złoty'
        WHEN barwa_ebc >= 12 THEN 'Jasny bursztyn'
        WHEN barwa_ebc >= 16 THEN 'Bursztynowy'
        WHEN barwa_ebc >= 20 THEN 'Głęboki bursztyn'
        WHEN barwa_ebc >= 26 THEN 'Miedziany'
        WHEN barwa_ebc >= 33 THEN 'Ciemny Miedziany'
        WHEN barwa_ebc >= 39 THEN 'Jasnobrązowy'
        WHEN barwa_ebc >= 47 THEN 'Brązowy'
        WHEN barwa_ebc >= 57 THEN 'Ciemnobrązowy'
        WHEN barwa_ebc >= 69 THEN 'Bardzo ciemny brąz'
        WHEN barwa_ebc >= 79 THEN 'Czarny opalizujący'
        ELSE 'Unknown'
    END;
END;
/


