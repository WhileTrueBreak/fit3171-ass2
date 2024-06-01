/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T4-pf-mods.sql

--Student ID: 33965501
--Student Name: Jeffrey Chen


/* Comments for your marker:




*/

ALTER TABLE SERVICE DROP COLUMN NONSTANDARD_COUNT;

/*(a)*/
SELECT * FROM SERVICE;

ALTER TABLE SERVICE ADD NONSTANDARD_COUNT NUMBER(5);

UPDATE SERVICE S
SET
	NONSTANDARD_COUNT = (
		SELECT
			COUNT(*)
		FROM
			VISIT_SERVICE VS
		WHERE
			VS.VISIT_SERVICE_LINECOST != S.SERVICE_STD_COST
			AND VS.SERVICE_CODE = S.SERVICE_CODE
	);
	
SELECT * FROM SERVICE;

/*(b)*/

-- new table called payments (visit_id, payment_id, payment_amount, payment_type)
