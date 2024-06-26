--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-pf-schema.sql

--Student ID: 33965501
--Student Name: Jeffrey Chen


/* Comments for your marker:




*/

-- Task 1 Add Create table statements for the Missing TABLES below.
-- Ensure all column comments, and constraints (other than FK's)are included.
-- FK constraints are to be added at the end of this script

-- VISIT

CREATE TABLE VISIT (
    VISIT_ID NUMBER(5) NOT NULL,
    VISIT_DATE_TIME DATE NOT NULL,
    VISIT_LENGTH NUMBER(2) NOT NULL,
    VISIT_NOTES VARCHAR2(200),
    VISIT_WEIGHT NUMBER(4, 1),
    VISIT_TOTAL_COST NUMBER(6, 2),
    ANIMAL_ID NUMBER(5) NOT NULL,
    VET_ID NUMBER(4) NOT NULL,
    CLINIC_ID NUMBER(2) NOT NULL,
    FROM_VISIT_ID NUMBER(5)
);

ALTER TABLE VISIT ADD CONSTRAINT VISIT_PK PRIMARY KEY ( VISIT_ID );

COMMENT ON COLUMN VISIT.VISIT_ID IS
    'Visit identifier';
COMMENT ON COLUMN VISIT.VISIT_DATE_TIME IS
    'Date and time of visit';
COMMENT ON COLUMN VISIT.VISIT_LENGTH IS
    'Visit length in minutes';
COMMENT ON COLUMN VISIT.VISIT_NOTES IS
    'Vet notes from visit';
COMMENT ON COLUMN VISIT.VISIT_WEIGHT IS
    'Weight in Kgs';
COMMENT ON COLUMN VISIT.VISIT_TOTAL_COST IS
    'Total cost for this visit';
COMMENT ON COLUMN VISIT.ANIMAL_ID IS
    'Animal identifier';
COMMENT ON COLUMN VISIT.VET_ID IS
    'Identifier for the vet';
COMMENT ON COLUMN VISIT.CLINIC_ID IS
    'Identifier for the clinic';
COMMENT ON COLUMN VISIT.FROM_VISIT_ID IS
    'The previous visit’s identifier';

-- VISIT_DRUG

CREATE TABLE VISIT_DRUG (
    VISIT_ID NUMBER(5) NOT NULL,
    DRUG_ID NUMBER(4) NOT NULL,
    VISIT_DRUG_DOSE VARCHAR2(20) NOT NULL,
    VISIT_DRUG_FREQUENCY VARCHAR2(20),
    VISIT_DRUG_QTYSUPPLIED NUMBER(2) NOT NULL,
    VISIT_DRUG_LINECOST NUMBER(5, 2) NOT NULL
);

ALTER TABLE VISIT_DRUG ADD CONSTRAINT VISIT_DRUG_PK PRIMARY KEY ( VISIT_ID, DRUG_ID );

COMMENT ON COLUMN VISIT_DRUG.VISIT_ID IS
    'Identifier for visit';
COMMENT ON COLUMN VISIT_DRUG.DRUG_ID IS
    'Drug identifier';
COMMENT ON COLUMN VISIT_DRUG.VISIT_DRUG_DOSE IS
    'Dose prescribed in this visit';
COMMENT ON COLUMN VISIT_DRUG.VISIT_DRUG_FREQUENCY IS
    'Frequency prescribed for this drug for this visit';
COMMENT ON COLUMN VISIT_DRUG.VISIT_DRUG_QTYSUPPLIED IS
    'Quantity of drug supplied';
COMMENT ON COLUMN VISIT_DRUG.VISIT_DRUG_LINECOST IS
    'Cost charged for drug in this visit';

-- VISIT_SERVICE

CREATE TABLE VISIT_SERVICE (
    VISIT_ID NUMBER(5) NOT NULL,
    SERVICE_CODE CHAR(5) NOT NULL,
    VISIT_SERVICE_LINECOST NUMBER(6, 2)
);

ALTER TABLE VISIT_SERVICE ADD CONSTRAINT VISIT_SERVICE_PK PRIMARY KEY ( VISIT_ID, SERVICE_CODE );

COMMENT ON COLUMN VISIT_SERVICE.VISIT_ID IS
    'Identifier for visit';
COMMENT ON COLUMN VISIT_SERVICE.SERVICE_CODE IS
    'Service identifier';
COMMENT ON COLUMN VISIT_SERVICE.VISIT_SERVICE_LINECOST IS
    'Cost charged for this service in this visit';

-- Add all missing FK Constraints below here

-- foreign key constraints
ALTER TABLE VISIT ADD CONSTRAINT VISIT_ANIMAL_FK FOREIGN KEY ( ANIMAL_ID ) REFERENCES ANIMAL ( ANIMAL_ID );

ALTER TABLE VISIT ADD CONSTRAINT VISIT_VET_FK FOREIGN KEY ( VET_ID ) REFERENCES VET ( VET_ID );

ALTER TABLE VISIT ADD CONSTRAINT VISIT_CLINIC_FK FOREIGN KEY ( CLINIC_ID ) REFERENCES CLINIC ( CLINIC_ID );

ALTER TABLE VISIT ADD CONSTRAINT VISIT_VISIT_FK FOREIGN KEY ( FROM_VISIT_ID ) REFERENCES VISIT ( VISIT_ID );

ALTER TABLE VISIT_DRUG ADD CONSTRAINT VISIT_DRUG_VISIT_FK FOREIGN KEY ( VISIT_ID ) REFERENCES VISIT ( VISIT_ID );

ALTER TABLE VISIT_DRUG ADD CONSTRAINT VISIT_DRUG_DRUG_FK FOREIGN KEY ( DRUG_ID ) REFERENCES DRUG ( DRUG_ID );

ALTER TABLE VISIT_SERVICE ADD CONSTRAINT VISIT_SERVICE_VISIT_FK FOREIGN KEY ( VISIT_ID ) REFERENCES VISIT ( VISIT_ID );

ALTER TABLE VISIT_SERVICE ADD CONSTRAINT VISIT_SERVICE_SERVICE_FK FOREIGN KEY ( SERVICE_CODE ) REFERENCES SERVICE ( SERVICE_CODE );

-- unique constraints
ALTER TABLE VISIT ADD CONSTRAINT VISIT_UNIQ UNIQUE (VISIT_DATE_TIME, ANIMAL_ID);