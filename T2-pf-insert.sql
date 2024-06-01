/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-pf-insert.sql

--Student ID: 33965501
--Student Name: Jeffrey Chen

/* Comments for your marker:




*/

--------------------------------------
--INSERT INTO visit
--------------------------------------

INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id)
VALUES (1, TO_DATE('2024-04-08 12:58:24', 'YYYY-MM-DD HH24:MI:SS'), 20, NULL, 11, 180, 2, 1005, 2);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id)
VALUES (2, TO_DATE('2024-04-12 08:23:54', 'YYYY-MM-DD HH24:MI:SS'), 24, NULL, 12, 342, 12, 1001, 1);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id)
VALUES (3, TO_DATE('2024-04-23 23:58:24', 'YYYY-MM-DD HH24:MI:SS'), 14, NULL, 8, 170, 10, 1011, 4);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (4, TO_DATE('2024-05-09 19:58:24', 'YYYY-MM-DD HH24:MI:SS'), 15, NULL, 9, 223, 10, 1011, 4, 3);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id)
VALUES (5, TO_DATE('2024-05-23 12:58:24', 'YYYY-MM-DD HH24:MI:SS'), 19, NULL, 15, 170, 4, 1002, 4);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id)
VALUES (6, TO_DATE('2024-05-02 12:58:24', 'YYYY-MM-DD HH24:MI:SS'), 5, NULL, 2, 540, 5, 1004, 3);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id)
VALUES (7, TO_DATE('2024-05-26 12:58:24', 'YYYY-MM-DD HH24:MI:SS'), 15, NULL, 3, 250, 7, 1007, 5);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id)
VALUES (8, TO_DATE('2024-05-19 12:58:24', 'YYYY-MM-DD HH24:MI:SS'), 28, NULL, 4, 290, 6, 1003, 2);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id)
VALUES (9, TO_DATE('2024-06-20 12:58:24', 'YYYY-MM-DD HH24:MI:SS'), 12, NULL, 12, 105, 8, 1009, 5);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (10, TO_DATE('2024-06-30 12:58:24', 'YYYY-MM-DD HH24:MI:SS'), 31, NULL, 10, 60, 2, 1008, 3, 1);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id)
VALUES (11, TO_DATE('2024-06-30 19:58:24', 'YYYY-MM-DD HH24:MI:SS'), 15, NULL, 11, 250, 10, 1011, 4, 4);

--------------------------------------
--INSERT INTO visit_service
--------------------------------------

INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (1, 'S001', 55);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (2, 'S011', 90);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (3, 'S016', 130);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (4, 'S002', 45);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (5, 'S008', 40);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (6, 'S006', 80);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (7, 'S020', 90);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (8, 'S004', 150);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (9, 'S001', 60);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (10, 'S001', 60);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (11, 'S016', 130);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (1, 'S005', 125);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (4, 'S016', 130);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (6, 'S001', 60);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
VALUES (9, 'S002', 45);

--------------------------------------
--INSERT INTO visit_drug
--------------------------------------

INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (2, 101, '60mg', NULL, 10, 120);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (2, 114, '0.12mg', NULL, 3, 42);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (3, 116, '80mg', NULL, 5, 40);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (4, 116, '89mg', NULL, 3, 24);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (5, 108, '10mg', 'once a month', 1, 45);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (5, 109, '50mg', NULL, 10, 45);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (6, 106, '0.2mg', NULL, 20, 200);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (7, 120, '50mg', NULL, 2, 160);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (8, 104, '0.9mg', NULL, 2, 140);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost)
VALUES (11, 101, '55mg', 'twice daily', 10, 120);

COMMIT;