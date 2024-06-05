/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T6-pf-json.sql

--Student ID: 33965501
--Student Name: Jeffrey Chen


/* Comments for your marker:




*/

-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

-- generate json documents for each clinic
SELECT
	JSON_OBJECT(
		'_id' IS CL.CLINIC_ID, 
		'name' IS CL.CLINIC_NAME, 
		'address' IS CL.CLINIC_ADDRESS, 
		'phone' IS CL.CLINIC_PHONE, 
		'head_vet' IS JSON_OBJECT('id' IS V.VET_ID, 'name' IS V.VET_GIVENNAME||' '||V.VET_FAMILYNAME), 
		'no_of_vets' IS VS.VET_COUNT, 
		'vets' IS VS.VETS) as CLINIC_JSON
FROM
	CLINIC CL
	JOIN (
		SELECT
			JSON_ARRAYAGG( JSON_OBJECT( 
				'id' IS V.VET_ID, 
				'name' IS V.VET_GIVENNAME||' '||V.VET_FAMILYNAME, 
				'specialisation' IS COALESCE(S.SPEC_DESCRIPTION, 'N/A') ) ) AS VETS,
			COUNT(*)                                                                                                                                AS VET_COUNT,
			V.CLINIC_ID
		FROM
			VET            V
			LEFT JOIN SPECIALISATION S
			ON V.SPEC_ID = S.SPEC_ID
		GROUP BY
			V.CLINIC_ID
	) VS
	ON CL.CLINIC_ID = VS.CLINIC_ID
	JOIN VET V
	ON CL.VET_ID = V.VET_ID

