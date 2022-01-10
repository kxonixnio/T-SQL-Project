/*
Si³ownia
Baza danych dotycz¹ca lokalnej si³owni. Przechowuje ona informacje o pracownikach (ich stanowiskach, zmianach i mieœcie zamieszkania) oraz klientach (ich karnetach oraz mieœcie zamieszkania)

-Ka¿dy pracownik posiada id, imiê, nazwisko, telefon kontaktowy, w³asn¹ premiê oraz informacjê o mieœcie zamieszkania i zajmowanym stanowisku.
-Ka¿dy klient posiada id, imiê, nazwisko, telefon kontaktowy oraz informacjê o mieœcie zamieszkania i posiadanym karnecie
-Ka¿dy karnet posiada id, datê wydania oraz swój rodzaj.
-Ka¿dy rodzaj karnetu ma swoje id, nazwê oraz iloœæ dni, przez któr¹ jest wa¿ny.
-Ka¿de stanowisko ma swoje id, nazwê i stawkê na godzinê.
-Ka¿da zmiana ma swoje id oraz informacjê o dacie, pracowniku którego zmiana ta dotyczy oraz iloœci czasu jak¹ przepracowa³.
-Zak³adamy, ¿e pracownik nie mo¿e byæ klientem - to jest nie posiada karnetu (mo¿e korzystaæ z si³owni za darmo)
*/

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-06-20 12:03:24.736

DROP TABLE IF EXISTS KLIENT;
GO
DROP TABLE IF EXISTS ZMIANA;
GO
DROP TABLE IF EXISTS PRACOWNIK;
GO
DROP TABLE IF EXISTS KARNET;
GO
DROP TABLE IF EXISTS MIASTO;
GO
DROP TABLE IF EXISTS RODZAJ;
GO
DROP TABLE IF EXISTS STANOWISKO;
GO

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-11-15 08:51:18.476

-- tables
-- Table: karnet
CREATE TABLE karnet (
    id_karnet int  NOT NULL,
    data_wydania date  NOT NULL,
    id_rodzaj int  NOT NULL,
    CONSTRAINT karnet_pk PRIMARY KEY  (id_karnet)
);
GO

-- Table: klient
CREATE TABLE klient (
    id_klient int  NOT NULL,
    imie varchar(20)  NOT NULL,
    nazwisko varchar(20)  NOT NULL,
    telefon numeric(9,0)  NOT NULL,
    id_miasto int  NOT NULL,
    id_karnet int  NOT NULL,
    CONSTRAINT klient_pk PRIMARY KEY  (id_klient)
);
GO

-- Table: miasto
CREATE TABLE miasto (
    id_miasto int  NOT NULL,
    miasto varchar(20)  NOT NULL,
    CONSTRAINT miasto_pk PRIMARY KEY  (id_miasto)
);
GO

-- Table: pracownik
CREATE TABLE pracownik (
    id_pracownik int  NOT NULL,
    imie varchar(20)  NOT NULL,
    nazwisko varchar(20)  NOT NULL,
    telefon numeric(9,0)  NOT NULL,
    premia money  NOT NULL,
    id_miasto int  NOT NULL,
    id_stanowisko int  NOT NULL,
    CONSTRAINT pracownik_pk PRIMARY KEY  (id_pracownik)
);
GO

-- Table: rodzaj
CREATE TABLE rodzaj (
    id_rodzaj int  NOT NULL,
    nazwa varchar(20)  NOT NULL,
    ilosc_dni int  NOT NULL,
    CONSTRAINT rodzaj_pk PRIMARY KEY  (id_rodzaj)
);
GO

-- Table: stanowisko
CREATE TABLE stanowisko (
    id_stanowisko int  NOT NULL,
    nazwa varchar(20)  NOT NULL,
    stawka money  NOT NULL,
    CONSTRAINT stanowisko_pk PRIMARY KEY  (id_stanowisko)
);
GO

-- Table: zmiana
CREATE TABLE zmiana (
    id_zmiany int  NOT NULL,
    data date  NOT NULL,
    czas_pracy numeric(3,1)  NOT NULL,
    id_pracownik int  NOT NULL,
    CONSTRAINT zmiana_pk PRIMARY KEY  (id_zmiany)
);
GO

-- foreign keys
-- Reference: karnet_rodzaj (table: karnet)
ALTER TABLE karnet ADD CONSTRAINT karnet_rodzaj
    FOREIGN KEY (id_rodzaj)
    REFERENCES rodzaj (id_rodzaj);
GO

-- Reference: klient_karnet (table: klient)
ALTER TABLE klient ADD CONSTRAINT klient_karnet
    FOREIGN KEY (id_karnet)
    REFERENCES karnet (id_karnet);
GO

-- Reference: klient_miasto (table: klient)
ALTER TABLE klient ADD CONSTRAINT klient_miasto
    FOREIGN KEY (id_miasto)
    REFERENCES miasto (id_miasto);
GO

-- Reference: pracownik_miasto (table: pracownik)
ALTER TABLE pracownik ADD CONSTRAINT pracownik_miasto
    FOREIGN KEY (id_miasto)
    REFERENCES miasto (id_miasto);
GO

-- Reference: pracownik_stanowisko (table: pracownik)
ALTER TABLE pracownik ADD CONSTRAINT pracownik_stanowisko
    FOREIGN KEY (id_stanowisko)
    REFERENCES stanowisko (id_stanowisko);
GO

-- Reference: zmiana_pracownik (table: zmiana)
ALTER TABLE zmiana ADD CONSTRAINT zmiana_pracownik
    FOREIGN KEY (id_pracownik)
    REFERENCES pracownik (id_pracownik);
GO
-- End of file.



INSERT INTO miasto VALUES (0, 'WARSZAWA');
INSERT INTO miasto VALUES (1, 'PIASECZNO');
INSERT INTO miasto VALUES (2, 'PIASTOW');

INSERT INTO stanowisko VALUES (0, 'RECEPCJA', 22);
INSERT INTO stanowisko VALUES (1, 'TRENER', 27);
INSERT INTO stanowisko VALUES (2, 'MANAGER', 50);

INSERT INTO rodzaj VALUES (0, 'STANDARD', 30);
INSERT INTO rodzaj VALUES (1, 'STANDARD', 60);
INSERT INTO rodzaj VALUES (2, 'STANDARD', 90);
INSERT INTO rodzaj VALUES (3, 'PREMIUM', 30);
INSERT INTO rodzaj VALUES (4, 'PREMIUM', 60);
INSERT INTO rodzaj VALUES (5, 'PREMIUM', 90);
INSERT INTO rodzaj VALUES (6, 'VIP', 30);
INSERT INTO rodzaj VALUES (7, 'VIP', 60);
INSERT INTO rodzaj VALUES (8, 'VIP', 90);

INSERT INTO karnet VALUES (0, '2020-05-01', 0);
INSERT INTO karnet VALUES (1, '2020-05-01', 0);
INSERT INTO karnet VALUES (2, '2020-05-03', 0);
INSERT INTO karnet VALUES (3, '2020-05-03', 2);
INSERT INTO karnet VALUES (4, '2020-05-03', 3);
INSERT INTO karnet VALUES (5, '2020-05-03', 4);
INSERT INTO karnet VALUES (6, '2020-05-04', 4);
INSERT INTO karnet VALUES (7, '2020-05-04', 4);
INSERT INTO karnet VALUES (8, '2020-05-05', 5);
INSERT INTO karnet VALUES (9, '2020-05-06', 8);
INSERT INTO karnet VALUES (10, '2020-05-07', 8);

INSERT INTO klient VALUES (0, 'JAN', 'PAPAYA', 502101123, 0, 0);
INSERT INTO klient VALUES (1, 'TOMASZ', 'HENDRICK', 798417132, 0, 1);
INSERT INTO klient VALUES (2, 'JERZY', 'PISZCZEK', 497614723, 0, 2);
INSERT INTO klient VALUES (3, 'MAGDALENA', 'MAZUREK', 791487315, 0, 3);
INSERT INTO klient VALUES (4, 'ALICJA', 'NESBO', 123654824, 0, 4);
INSERT INTO klient VALUES (5, 'ANNA', 'PIORKOWSKA', 645978357, 0, 5);
INSERT INTO klient VALUES (6, 'ROBERT', 'PIASECZNY', 753951486, 1, 6);
INSERT INTO klient VALUES (7, 'SYLWIA', 'PIASECZNA', 489276134, 1, 7);
INSERT INTO klient VALUES (8, 'MICHAL', 'DROPSKI', 456987789, 1, 8);
INSERT INTO klient VALUES (9, 'WERONIKA', 'DRZEWKO', 456789370, 2, 9);
INSERT INTO klient VALUES (10, 'WIKTORIA', 'CHODZKO', 498761002, 2, 10);

INSERT INTO pracownik VALUES (0, 'ZUZANNA', 'KUNOWSKA', 100111222, 100, 0, 0);
INSERT INTO pracownik VALUES (1, 'WIKTORIA', 'KOLODZIEJCZYK', 252141363, 0, 0, 0);
INSERT INTO pracownik VALUES (2, 'ALICJA', 'OFICJALSKA', 474585696, 300, 0, 0);
INSERT INTO pracownik VALUES (3, 'ALICJA', 'KUCHARSKA', 989656323, 200, 1, 0);
INSERT INTO pracownik VALUES (4, 'MARCIN', 'OCHMAN', 761349852, 0, 1, 0);
INSERT INTO pracownik VALUES (5, 'KUBA', 'STEPIEN', 793182456, 250, 2, 0);
INSERT INTO pracownik VALUES (6, 'NAPOLEON', 'NORKOWSKI', 456913782, 500, 1, 1);
INSERT INTO pracownik VALUES (7, 'MAKS', 'JELENIEWSKI', 201302403, 300, 1, 1);
INSERT INTO pracownik VALUES (8, 'JULIA', 'WOLSKA', 979731564, 000, 2, 1);
INSERT INTO pracownik VALUES (9, 'PIOTR', 'SIARA', 456654004, 800, 0, 2);

INSERT INTO zmiana VALUES (0, '2020-05-01', 7, 0);
INSERT INTO zmiana VALUES (1, '2020-05-01', 8, 1);
INSERT INTO zmiana VALUES (2, '2020-05-01', 6, 2);
INSERT INTO zmiana VALUES (3, '2020-05-02', 9, 3);
INSERT INTO zmiana VALUES (4, '2020-05-02', 8, 4);
INSERT INTO zmiana VALUES (5, '2020-05-02', 6, 5);
INSERT INTO zmiana VALUES (6, '2020-05-03', 8, 6);
INSERT INTO zmiana VALUES (7, '2020-05-03', 8, 7);
INSERT INTO zmiana VALUES (8, '2020-05-03', 6, 8);
INSERT INTO zmiana VALUES (9, '2020-05-04', 7, 0);
INSERT INTO zmiana VALUES (10, '2020-05-04', 10, 1);
INSERT INTO zmiana VALUES (11, '2020-05-04', 6, 2);
INSERT INTO zmiana VALUES (12, '2020-05-05', 7, 3);
INSERT INTO zmiana VALUES (13, '2020-05-05', 7, 4);
INSERT INTO zmiana VALUES (14, '2020-05-05', 10, 5);
INSERT INTO zmiana VALUES (15, '2020-05-06', 9, 6);
INSERT INTO zmiana VALUES (16, '2020-05-06', 9, 7);
INSERT INTO zmiana VALUES (17, '2020-05-06', 8, 0);
INSERT INTO zmiana VALUES (18, '2020-05-07', 9, 0);
INSERT INTO zmiana VALUES (19, '2020-05-07', 8, 4);
INSERT INTO zmiana VALUES (20, '2020-05-07', 7, 7);
INSERT INTO zmiana VALUES (21, '2020-05-01', 6, 9);
INSERT INTO zmiana VALUES (22, '2020-05-03', 8, 9);
INSERT INTO zmiana VALUES (23, '2020-05-05', 12, 9);
INSERT INTO zmiana VALUES (24, '2020-05-06', 5, 9);

--------------------------------------------------------------------------------------------------------------------
/*
Procedura, która przyjmuj¹c jako parametr numer miesi¹ca zwiêksza premiê pracownika, który przepracowa³ najwiêcej godzin w podanym miesi¹cu.
Premia wynosi œredni¹ premii wszystkich pracowników, którzy pracuj¹ na tym samym stanowisku, co premiowany pracownik.
Pracowników miesi¹ca mo¿e byæ kilku (je¿eli suma przepracowanych godzin tych pracowników jest równa sobie i wiêksza wzglêdem pozosta³ych pracowników)
*/

--Funkcja niezbêdna do procedury EmployeeOfTheMonthBonus
CREATE FUNCTION FN_EmployeesWorktime(@month INT)
RETURNS TABLE
AS
RETURN
(
	SELECT id_pracownik, SUM(czas_pracy) czas_pracy
	FROM zmiana
	WHERE MONTH(data) = @month AND YEAR(data) = 2020
	GROUP BY id_pracownik
)
GO

CREATE PROCEDURE EmployeeOfTheMonthBonus @month INT
AS
BEGIN

	IF @month < 1  OR @month > 12
		BEGIN
			RAISERROR ('Month must be between 1 and 12!',15,1)
		END	

	DECLARE eachEOTMcursor CURSOR FOR 
			SELECT id_pracownik
			FROM FN_EmployeesWorktime(@month)
			WHERE czas_pracy = (
				SELECT MAX(czas_pracy)
				FROM FN_EmployeesWorktime(@month)
			);

	DECLARE @employeeID INT, @currentBonus MONEY;
	OPEN eachEOTMcursor;
	FETCH NEXT FROM eachEOTMcursor INTO @employeeID;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--
	DECLARE @bonus MONEY;
	SET @bonus = (
		SELECT AVG(premia)
		FROM pracownik
		WHERE id_stanowisko = (
			SELECT id_stanowisko
			FROM pracownik
			WHERE id_pracownik = @employeeID
		)
	);

	DECLARE @nameAndSurname VARCHAR(20);
	SET @nameAndSurname = (
		SELECT CONCAT(imie, ' ' , nazwisko) FROM pracownik WHERE id_pracownik = @employeeID
	);

	UPDATE pracownik
	SET premia += @bonus
	WHERE id_pracownik = @employeeID;
	PRINT 'Premia dla pracownika ' + @nameAndSurname + ' zosta³a podwy¿szona o ' + CAST(@bonus AS VARCHAR);
		--
	FETCH NEXT FROM eachEOTMcursor INTO @employeeID;
	END;

	CLOSE eachEOTMcursor;
	DEALLOCATE eachEOTMcursor;

END

EXECUTE EmployeeOfTheMonthBonus 5
DROP FUNCTION s22472.FN_EmployeesWorktime()

--------------------------------------------------------------------------------------------------------------------

/*
Jeden wyzwalacz, który:
-Nie pozwala usuwaæ pracownika na stanowisku 'MANAGER'
-Nie pozwala wstawiæ pracownika, który ju¿ istnieje (sprawdzaj¹c po nazwisku i numerze telefonu)
-Nie pozwala zmieniæ premii pracownika, na wiêcej ni¿ 1000 (przy podjêciu takiej próby ustawia premiê na 1000 i informuje o tym odpowiednim komunikatem)
*/

CREATE TRIGGER EmployeesTrigger ON pracownik
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;

--Nie pozwala usuwaæ pracownika na stanowisku 'MANAGER'
IF EXISTS(
	SELECT 1
	FROM deleted
	WHERE id_stanowisko = (
		SELECT id_stanowisko
		FROM stanowisko
		WHERE nazwa = 'MANAGER')
	AND NOT EXISTS(SELECT 1 FROM inserted))		--DELETE
	BEGIN
		ROLLBACK;
		RAISERROR ('Nie mo¿na usun¹æ Managera!',15,1)
	END

--Nie pozwala wstawiæ pracownika, który ju¿ istnieje (sprawdzaj¹c po nazwisku i numerze telefonu)
IF EXISTS (
	SELECT *
	FROM pracownik p
	INNER JOIN inserted i ON (i.nazwisko = p.nazwisko OR i.telefon = p.telefon) AND i.id_pracownik <> p.id_pracownik
	AND NOT EXISTS(SELECT 1 FROM deleted))	--INSERT
	BEGIN
		ROLLBACK;
		RAISERROR ('Zduplikowany pracownik!',15,1)
	END

--Nie pozwala zmieniæ premii pracownika, na wiêcej ni¿ 1000 (przy podjêciu takiej próby ustawia premiê na 1000 i informuje o tym odpowiednim komunikatem)
IF EXISTS(
	SELECT 1
	FROM inserted i INNER JOIN deleted d ON i.id_pracownik = d.id_pracownik		--UPDATE
	WHERE d.premia <= 1000 AND i.premia > 1000
	)
	BEGIN
		RAISERROR ('Premia nie mo¿e byæ wiêksza ni¿ 1000! Premia wynosi: 1000',15,1)
		UPDATE pracownik
		SET premia = 1000
		WHERE id_pracownik = (
			SELECT i.id_pracownik
			FROM inserted i INNER JOIN deleted d ON i.id_pracownik = d.id_pracownik
			WHERE d.premia <= 1000 AND i.premia > 1000)
	END

END

--INSERT INTO pracownik VALUES (10, 'TEST', 'TEST', 456654001, 100, 0, 2);
--DROP TRIGGER EmployeesTrigger
--DELETE FROM pracownik WHERE id_pracownik = 12

--INSERT INTO pracownik VALUES (10, 'xyz', 'xyz', 123456789, 100, 0, 2);
--INSERT INTO pracownik VALUES (11, 'TEST', 'TESTT', 456654001, 100, 0, 2);
--INSERT INTO pracownik VALUES (13, 'TESTUNIO', 'TEST', 456654007, 100, 0, 2);

--UPDATE pracownik
--SET premia = 800
--WHERE id_pracownik = 9;

--SELECT * FROM pracownik

--https://stackoverflow.com/questions/20205639/insert-delete-update-trigger-in-sql-server