set echo off;

spool 'drop.sql';

SELECT
    'DROP TABLE "'
    || table_name
    || '" CASCADE CONSTRAINTS;'
FROM
    user_tables;

spool off;