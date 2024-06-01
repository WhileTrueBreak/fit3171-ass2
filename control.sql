set serveroutput off
set echo off
set feedback off
set verify off

@pf_initialSchemaInsert.sql
@T1-pf-schema.sql
@T2-pf-insert.sql

set serveroutput on
set echo on
set feedback on
set verify on

@T3-pf-dml.sql