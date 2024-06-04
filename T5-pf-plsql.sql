--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-pf-plsql.sql

--Student ID: 33965501
--Student Name: Jeffrey Chen

/* Comments for your marker:


*/


--(a)
--Write your trigger statement,
--finish it with a slash(/) followed by a blank line
-- CREATE OR REPLACE TRIGGER TR_SERVICE_COST_IN_RANGE BEFORE
--     INSERT ON VISIT_SERVICE FOR EACH ROW
-- DECLARE
--     VAR_SERVICE_STD_COST NUMBER;
--     VAR_LOWER_COST       NUMBER;
--     VAR_UPPER_COST       NUMBER;
-- BEGIN
--     SELECT
--         S.SERVICE_STD_COST INTO VAR_SERVICE_STD_COST
--     FROM
--         SERVICE S
--     WHERE
--         S.SERVICE_CODE = :NEW.SERVICE_CODE;
--     VAR_LOWER_COST := VAR_SERVICE_STD_COST * 0.9;
--     VAR_UPPER_COST := VAR_SERVICE_STD_COST * 1.1;
--     IF (:NEW.VISIT_SERVICE_LINECOST < VAR_LOWER_COST
--     OR :NEW.VISIT_SERVICE_LINECOST > VAR_UPPER_COST) THEN
--         RAISE_APPLICATION_ERROR(-20000, 'Line cost must be within 10%');
--     END IF;
-- END;
-- /

CREATE OR REPLACE TRIGGER TR_SERVICE_COST_CHECK FOR
    INSERT OR UPDATE OR DELETE ON VISIT_SERVICE
COMPOUND TRIGGER

    BEFORE EACH ROW IS
        VAR_SERVICE_STD_COST NUMBER;
        VAR_LOWER_COST       NUMBER;
        VAR_UPPER_COST       NUMBER;
    BEGIN
        IF INSERTING THEN
            SELECT
                S.SERVICE_STD_COST INTO VAR_SERVICE_STD_COST
            FROM
                SERVICE S
            WHERE
                S.SERVICE_CODE = :NEW.SERVICE_CODE;
            VAR_LOWER_COST := VAR_SERVICE_STD_COST * 0.9;
            VAR_UPPER_COST := VAR_SERVICE_STD_COST * 1.1;
            IF (:NEW.VISIT_SERVICE_LINECOST < VAR_LOWER_COST
            OR :NEW.VISIT_SERVICE_LINECOST > VAR_UPPER_COST) THEN
                RAISE_APPLICATION_ERROR(-20001, 'Line cost must be within 10%');
            END IF;
        END IF;
    END BEFORE EACH ROW;

    AFTER EACH ROW IS
    BEGIN
        IF INSERTING THEN
            UPDATE VISIT V
            SET
                V.VISIT_TOTAL_COST = V.VISIT_TOTAL_COST + :NEW.VISIT_SERVICE_LINECOST
            WHERE
                V.VISIT_ID = :NEW.VISIT_ID;
        ELSIF UPDATING THEN
            UPDATE VISIT V
            SET
                V.VISIT_TOTAL_COST = V.VISIT_TOTAL_COST + :NEW.VISIT_SERVICE_LINECOST
            WHERE
                V.VISIT_ID = :NEW.VISIT_ID;
            UPDATE VISIT V
            SET
                V.VISIT_TOTAL_COST = V.VISIT_TOTAL_COST + :OLD.VISIT_SERVICE_LINECOST
            WHERE
                V.VISIT_ID = :OLD.VISIT_ID;
        ELSIF DELETING THEN
            UPDATE VISIT V
            SET
                V.VISIT_TOTAL_COST = V.VISIT_TOTAL_COST + :OLD.VISIT_SERVICE_LINECOST
            WHERE
                V.VISIT_ID = :OLD.VISIT_ID;
        END IF;
    END AFTER EACH ROW;
END;
/

-- Write Test Harness for (a)
-- initial data
SELECT * FROM VISIT;
SELECT * FROM VISIT_SERVICE;
BEGIN
    INSERT INTO VISIT_SERVICE (visit_id, service_code, visit_service_linecost)
    VALUES (1, 'S016', 130);
END;
/
BEGIN
    INSERT INTO VISIT_SERVICE (visit_id, service_code, visit_service_linecost)
    VALUES (1, 'S004', 135);
END;
/
SELECT * FROM VISIT;
SELECT * FROM VISIT_SERVICE;
ROLLBACK;

--(b)
-- Complete the procedure below
CREATE OR REPLACE PROCEDURE PRC_FOLLOWUP_VISIT (
    P_PREVVISIT_ID IN NUMBER,
    P_NEWVISIT_DATETIME IN DATE,
    P_NEWVISIT_LENGTH IN NUMBER,
    P_OUTPUT OUT VARCHAR2
) IS
    VAR_PREV_ANIMAL NUMBER;
    VAR_PREV_VET    NUMBER;
    VAR_PREV_CLINIC NUMBER;
BEGIN
    SELECT
        V.ANIMAL_ID INTO VAR_PREV_ANIMAL
    FROM
        VISIT V
    WHERE
        V.VISIT_ID = P_PREVVISIT_ID;
    SELECT
        V.VET_ID INTO VAR_PREV_VET
    FROM
        VISIT V
    WHERE
        V.VISIT_ID = P_PREVVISIT_ID;
    SELECT
        V.CLINIC_ID INTO VAR_PREV_CLINIC
    FROM
        VISIT V
    WHERE
        V.VISIT_ID = P_PREVVISIT_ID;
    INSERT INTO VISIT (
        VISIT_ID,
        VISIT_DATE_TIME,
        VISIT_LENGTH,
        ANIMAL_ID,
        VET_ID,
        CLINIC_ID
    ) VALUES (
        VISIT_PK_SEQ.NEXTVAL,
        P_NEWVISIT_DATETIME,
        P_NEWVISIT_LENGTH,
        VAR_PREV_ANIMAL,
        VAR_PREV_VET,
        VAR_PREV_CLINIC
    );
END;
/

-- Write Test Harness for (b)
-- initial data