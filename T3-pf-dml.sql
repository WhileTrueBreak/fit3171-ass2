/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T3-pf-dml.sql

--Student ID: 33965501
--Student Name: Jeffrey Chen

/* Comments for your marker:




*/

/*(a)*/

DROP SEQUENCE VISIT_PK_SEQ;

CREATE SEQUENCE VISIT_PK_SEQ INCREMENT BY 10 START WITH 100;

/*(b)*/

CREATE OR REPLACE PROCEDURE PRC_NEW_VISIT(
	P_VET_FNAME IN VARCHAR2,
	P_VET_LNAME IN VARCHAR2,
	P_VISIT_DATE IN DATE,
	P_VISIT_DURATION IN NUMBER,
	P_OWNER_FNAME IN VARCHAR2,
	P_OWNER_LNAME IN VARCHAR2,
	P_ANIMAL_NAME IN VARCHAR2,
	P_ANIMAL_TYPE IN VARCHAR2,
	P_CLINIC_ID IN NUMBER,
	P_VISIT_ID OUT NUMBER
) IS
	VAR_ANIMAL_ID NUMBER;
	VAR_VET_ID    NUMBER;
	VAR_VISIT_ID  NUMBER;
BEGIN
	SELECT
		A.ANIMAL_ID INTO VAR_ANIMAL_ID
	FROM
		OWNER       O
		JOIN ANIMAL A
		ON O.OWNER_ID = A.OWNER_ID
		JOIN ANIMAL_TYPE AT
		ON AT.ATYPE_ID = A.ATYPE_ID
	WHERE
		UPPER(O.OWNER_GIVENNAME) = UPPER(P_OWNER_FNAME)
		AND UPPER(O.OWNER_FAMILYNAME) = UPPER(P_OWNER_LNAME)
		AND UPPER(A.ANIMAL_NAME) = UPPER(P_ANIMAL_NAME)
		AND UPPER(AT.ATYPE_DESCRIPTION) = UPPER(P_ANIMAL_TYPE)
		AND ROWNUM = 1;
	SELECT
		V.VET_ID INTO VAR_VET_ID
	FROM
		VET V
	WHERE
		UPPER(V.VET_GIVENNAME) = UPPER(P_VET_FNAME)
		AND UPPER(V.VET_FAMILYNAME) = UPPER(P_VET_LNAME)
		AND ROWNUM = 1;
	P_VISIT_ID := VISIT_PK_SEQ.NEXTVAL;
	INSERT INTO VISIT (
		VISIT_ID,
		VISIT_DATE_TIME,
		VISIT_LENGTH,
		VISIT_NOTES,
		VISIT_WEIGHT,
		VISIT_TOTAL_COST,
		ANIMAL_ID,
		VET_ID,
		CLINIC_ID
	) VALUES (
		P_VISIT_ID,
		P_VISIT_DATE,
		P_VISIT_DURATION,
		NULL,
		NULL,
		0,
		VAR_ANIMAL_ID,
		VAR_VET_ID,
		P_CLINIC_ID
	);
END;
/

CREATE OR REPLACE PROCEDURE PRC_ADD_VISIT_SERVICE(
	P_VISIT_ID IN NUMBER,
	P_SERVICE_CODE IN CHAR,
	P_SERVICE_COST IN NUMBER
) IS
	VAR_SERVICE_COST NUMBER;
BEGIN
	IF (P_SERVICE_COST IS NULL) THEN
		SELECT
			S.SERVICE_STD_COST INTO VAR_SERVICE_COST
		FROM
			SERVICE S
		WHERE
			UPPER(S.SERVICE_CODE) = UPPER(P_SERVICE_CODE)
			AND ROWNUM = 1;
		INSERT INTO VISIT_SERVICE (
			VISIT_ID,
			SERVICE_CODE,
			VISIT_SERVICE_LINECOST
		) VALUES (
			P_VISIT_ID,
			P_SERVICE_CODE,
			VAR_SERVICE_COST
		);
	ELSE
		INSERT INTO VISIT_SERVICE (
			VISIT_ID,
			SERVICE_CODE,
			VISIT_SERVICE_LINECOST
		) VALUES (
			P_VISIT_ID,
			P_SERVICE_CODE,
			P_SERVICE_COST
		);
	END IF;
END;
/

CREATE OR REPLACE PROCEDURE PRC_CALC_VISIT_COST(
	P_VISIT_ID IN NUMBER
) IS
	VAR_TOTAL_COST NUMBER;
BEGIN
	SELECT
		(COALESCE(SUM(VISIT_DRUG_LINECOST), 0)+COALESCE(SUM(VISIT_SERVICE_LINECOST), 0)) INTO VAR_TOTAL_COST
	FROM
		VISIT_DRUG    D
		FULL OUTER JOIN VISIT_SERVICE S
		ON D.VISIT_ID = S.VISIT_ID
	HAVING
		S.VISIT_ID = P_VISIT_ID
	GROUP BY
		S.VISIT_ID;
	UPDATE VISIT V
	SET
		V.VISIT_TOTAL_COST = VAR_TOTAL_COST
	WHERE
		V.VISIT_ID = P_VISIT_ID;
	COMMIT;
END;
/

DECLARE
	VISIT_ID NUMBER;
BEGIN
	PRC_NEW_VISIT('Anna', 'KOWALSKI', TO_DATE('2024-05-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 30, 'Jack', 'JONES', 'Oreo', 'rabbit', 3, VISIT_ID);
	PRC_ADD_VISIT_SERVICE(VISIT_ID, 'S001', NULL);
	DBMS_OUTPUT.PUT_LINE(VISIT_ID);
	PRC_CALC_VISIT_COST(VISIT_ID);
	COMMIT;
END;
/

/*(c)*/

CREATE OR REPLACE PROCEDURE PRC_ADD_VISIT_DRUG(
	P_VISIT_ID IN NUMBER,
	P_DRUG_NAME IN VARCHAR2,
	P_DRUG_DOSE IN VARCHAR2,
	P_DRUG_FREQ IN VARCHAR2,
	P_DRUG_QTY IN NUMBER
) IS
	VAR_DRUG_COST NUMBER;
	VAR_DRUG_ID   NUMBER;
BEGIN
	SELECT
		D.DRUG_ID INTO VAR_DRUG_ID
	FROM
		DRUG D
	WHERE
		UPPER(D.DRUG_NAME) = UPPER(P_DRUG_NAME);
	SELECT
		D.DRUG_STD_COST INTO VAR_DRUG_COST
	FROM
		DRUG D
	WHERE
		UPPER(D.DRUG_NAME) = UPPER(P_DRUG_NAME);
	INSERT INTO VISIT_DRUG (
		VISIT_ID,
		DRUG_ID,
		VISIT_DRUG_DOSE,
		VISIT_DRUG_FREQUENCY,
		VISIT_DRUG_QTYSUPPLIED,
		VISIT_DRUG_LINECOST
	) VALUES (
		P_VISIT_ID,
		VAR_DRUG_ID,
		P_DRUG_DOSE,
		P_DRUG_FREQ,
		P_DRUG_QTY,
		P_DRUG_QTY*VAR_DRUG_COST
	);
END;
/

CREATE OR REPLACE PROCEDURE PRC_GET_VISIT_FROM_PET(
	P_VISIT_DATE IN DATE,
	P_OWNER_FNAME IN VARCHAR2,
	P_OWNER_LNAME IN VARCHAR2,
	P_ANIMAL_NAME IN VARCHAR2,
	P_ANIMAL_TYPE IN VARCHAR2,
	P_VISIT_ID OUT NUMBER
) IS
	VAR_ANIMAL_ID NUMBER;
BEGIN
	SELECT
		A.ANIMAL_ID INTO VAR_ANIMAL_ID
	FROM
		OWNER       O
		JOIN ANIMAL A
		ON O.OWNER_ID = A.OWNER_ID
		JOIN ANIMAL_TYPE AT
		ON AT.ATYPE_ID = A.ATYPE_ID
	WHERE
		UPPER(O.OWNER_GIVENNAME) = UPPER(P_OWNER_FNAME)
		AND UPPER(O.OWNER_FAMILYNAME) = UPPER(P_OWNER_LNAME)
		AND UPPER(A.ANIMAL_NAME) = UPPER(P_ANIMAL_NAME)
		AND UPPER(AT.ATYPE_DESCRIPTION) = UPPER(P_ANIMAL_TYPE)
		AND ROWNUM = 1;
	SELECT
		V.VISIT_ID INTO P_VISIT_ID
	FROM
		VISIT V
	WHERE
		V.VISIT_DATE_TIME = P_VISIT_DATE
		AND V.ANIMAL_ID = VAR_ANIMAL_ID;
END;
/

CREATE OR REPLACE PROCEDURE PRC_GET_SERVICE_FROM_NAME(
	P_SERVICE_NAME IN VARCHAR2,
	P_SERVICE_CODE OUT CHAR
)IS
BEGIN
	SELECT
		S.SERVICE_CODE INTO P_SERVICE_CODE
	FROM
		SERVICE S
	WHERE
		UPPER(S.SERVICE_DESC) = UPPER(P_SERVICE_NAME);
END;
/

CREATE OR REPLACE PROCEDURE PRC_ADD_FROM_VISIT(
	P_VISIT_ID1 IN NUMBER,
	P_VISIT_ID2 IN NUMBER
) IS
BEGIN
	UPDATE VISIT V
	SET
		V.FROM_VISIT_ID = P_VISIT_ID2
	WHERE
		V.VISIT_ID = P_VISIT_ID1;
	COMMIT;
END;
/

DECLARE
	VISIT_ID1    NUMBER(5);
	VISIT_ID2    NUMBER(5);
	SERVICE_CODE CHAR(5);
BEGIN
	PRC_GET_VISIT_FROM_PET(TO_DATE('2024-05-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Jack', 'JONES', 'Oreo', 'rabbit', VISIT_ID1);
	DBMS_OUTPUT.PUT_LINE(VISIT_ID1);
	PRC_GET_SERVICE_FROM_NAME('ear infection treatment', SERVICE_CODE);
	PRC_ADD_VISIT_SERVICE(VISIT_ID1, SERVICE_CODE, NULL);
	PRC_ADD_VISIT_DRUG(VISIT_ID1, 'Clotrimazole', '1 bottle', NULL, 1);
	PRC_CALC_VISIT_COST(VISIT_ID1);
	PRC_NEW_VISIT('Anna', 'KOWALSKI', TO_DATE('2024-05-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS')+7, 30, 'Jack', 'JONES', 'Oreo', 'rabbit', 3, VISIT_ID2);
	DBMS_OUTPUT.PUT_LINE(VISIT_ID2);
	PRC_ADD_FROM_VISIT(VISIT_ID2, VISIT_ID1);
	PRC_ADD_VISIT_SERVICE(VISIT_ID2, SERVICE_CODE, NULL);
	PRC_CALC_VISIT_COST(VISIT_ID2);
	COMMIT;
END;
/

/*(d)*/

CREATE OR REPLACE PROCEDURE PRC_DELETE_VISIT_BY_FROM(
	P_FROM_VISIT_ID IN NUMBER
) IS
	VAR_VISIT_ID NUMBER;
BEGIN
	SELECT
		V.VISIT_ID INTO PRC_DELETE_VISIT_BY_FROM.VAR_VISIT_ID
	FROM
		VISIT V
	WHERE
		V.FROM_VISIT_ID = PRC_DELETE_VISIT_BY_FROM.P_FROM_VISIT_ID
		AND ROWNUM = 1;
	DBMS_OUTPUT.PUT_LINE(VAR_VISIT_ID);
	DBMS_OUTPUT.PUT_LINE(P_FROM_VISIT_ID);
	DELETE FROM VISIT_DRUG V
	WHERE
		V.VISIT_ID = PRC_DELETE_VISIT_BY_FROM.VAR_VISIT_ID;
	DELETE FROM VISIT_SERVICE V
	WHERE
		V.VISIT_ID = PRC_DELETE_VISIT_BY_FROM.VAR_VISIT_ID;
	DELETE FROM VISIT V
	WHERE
		V.VISIT_ID = PRC_DELETE_VISIT_BY_FROM.VAR_VISIT_ID;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

DECLARE
	FROM_VISIT_ID NUMBER(5);
BEGIN
	PRC_GET_VISIT_FROM_PET( TO_DATE('2024-05-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Jack', 'JONES', 'Oreo', 'rabbit', FROM_VISIT_ID );
	PRC_DELETE_VISIT_BY_FROM(FROM_VISIT_ID);
	COMMIT;
END;
/
